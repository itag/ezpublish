<?php
//
// Created on: <16-Apr-2002 11:00:12 amos>
//
// Copyright (C) 1999-2002 eZ systems as. All rights reserved.
//
// This source file is part of the eZ publish (tm) Open Source Content
// Management System.
//
// This file may be distributed and/or modified under the terms of the
// "GNU General Public License" version 2 as published by the Free
// Software Foundation and appearing in the file LICENSE.GPL included in
// the packaging of this file.
//
// Licencees holding valid "eZ publish professional licences" may use this
// file in accordance with the "eZ publish professional licence" Agreement
// provided with the Software.
//
// This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING
// THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE.
//
// The "eZ publish professional licence" is available at
// http://ez.no/home/licences/professional/. For pricing of this licence
// please contact us via e-mail to licence@ez.no. Further contact
// information is available at http://ez.no/home/contact/.
//
// The "GNU General Public License" (GPL) is available at
// http://www.gnu.org/copyleft/gpl.html.
//
// Contact licence@ez.no if any conditions of this licencing isn't clear to
// you.
//


include_once( "kernel/classes/ezcontentclass.php" );
include_once( "lib/ezutils/classes/ezhttppersistence.php" );
include_once( "kernel/classes/ezcontentclassclassgroup.php" );

$Module =& $Params["Module"];
$GroupID = null;
if ( isset( $Params["GroupID"] ) )
    $GroupID =& $Params["GroupID"];
function &removeSelectedClasses( &$http, &$classes, $base )
{
    if ( $http->hasPostVariable( "DeleteButton" ) )
    {
        if ( eZHttpPersistence::splitSelected( $base,
                                               $classes, $http, "id",
                                               $keepers, $rejects ) )
        {
            $classes = $keepers;
            for ( $i = 0; $i < count( $rejects ); ++$i )
            {
                $reject =& $rejects[$i];
                $reject->remove( true );
                $ClassID =  $reject->attribute( "id" );
                $ClassVersion = $reject->attribute( "version" );
                eZContentClassClassGroup::removeClassMembers( $ClassID, $ClassVersion );
            }
        }
    }
}

$http =& eZHttpTool::instance();

if ( $http->hasPostVariable( "NewButton" ) )
{
    if ( $http->hasPostVariable( "CurrentGroupID" ) )
        $GroupID = $http->postVariable( "CurrentGroupID" );
    if ( $http->hasPostVariable( "CurrentGroupName" ) )
        $GroupName = $http->postVariable( "CurrentGroupName" );

    $params = array(null, $GroupID, $GroupName );
    $Module->run( "edit", $params );
    return;
}

$sorting = null;
if ( isset( $Params["SortingColumn"] ) )
{
    $sort_array = array( "id" => "id",
                         "name" => "name",
                         "identifier" => "identifier",
                         "status" => "version",
                         "creator" => "creator_id",
                         "modifier" => "modifier_id",
                         "created" => "created",
                         "modified" => "modified" );
    $sort_column = $Params["SortingColumn"];
    if ( isset( $sort_array[$sort_column] ) )
        $sorting = array( $sort_array[$sort_column] => "asc" );
    else
        eZDebug::writeError( "Undefined sorting column: $sort_column", "Class::list" );
}

if ( !isset( $TemplateData ) or !is_array( $TemplateData ) )
{
    $TemplateData = array( array( "name" => "groupclasses",
                                  "http_base" => "ContentClass",
                                  "data" => array( "command" => "groupclass_list",
                                                   "type" => "class" ) ) );
}

$Module->setTitle( "Class list of group" .$GroupID );
include_once( "kernel/common/template.php" );
$tpl =& templateInit();

include_once( "kernel/classes/datatypes/ezuser/ezuser.php" );
$user =& eZUser::currentUser();
foreach( $TemplateData as $tpldata )
{
    $tplname = $tpldata["name"];
    $data = $tpldata["data"];
    $as_object = isset( $data["as_object"] ) ? $data["as_object"] : true;
    $sort = isset( $data["sort"] ) ? $data["sort"] : null;
    $fields = isset( $data["fields"] ) ? $data["fields"] : null;
    $base = $tpldata["http_base"];
    $classids = & eZContentClassClassGroup::fetchClassList( 0, $GroupID, $as_object = true);
    $classes_list = & eZContentClass::fetchList( 0,
                                                 $as_object = true,
                                                 $user->attribute( "id" ),
                                                 $sort,
                                                 $fields );
    $list =array();
    for ( $i=0;$i<count( $classes_list );$i++ )
    {
        for ( $j=0;$j<count( $classids );$j++ )
        {
            $id =  $classes_list[$i]->attribute("id");
            $contentclass_id =  $classids[$j]->attribute("contentclass_id");
            if ( $id === $contentclass_id )
            {
                $list[] =& $classes_list[$i];
            }
        }
    }

    $temp_classids = & eZContentClassClassGroup::fetchClassList( 1, $GroupID, $as_object = true);
    $temp_classes_list = & eZContentClass::fetchList( 1,
                                                 $as_object = true,
                                                 $user->attribute( "id" ),
                                                      array("modified" => "modified"),
                                                 $fields );
    $temp_list = array();
    $temp_base = "TempContentClass";
    for ( $i=0;$i<count( $temp_classes_list );$i++ )
    {
        for ( $j=0;$j<count( $temp_classids );$j++ )
        {
            $id =  $temp_classes_list[$i]->attribute("id");
            $temp_contentclass_id =  $temp_classids[$j]->attribute("contentclass_id");
            if ( $id === $temp_contentclass_id )
            {
                $temp_list[] =& $temp_classes_list[$i];
            }
        }
    }
    removeSelectedClasses( $http, $list, $base );
    $tpl->setVariable( $tplname, $list );
    removeSelectedClasses( $http, $temp_list, $temp_base );
    $tpl->setVariable( "temp_groupclasses", $temp_list );
    $tpl->setVariable( "group_id", $GroupID );
    $groupInfo =  & eZContentClassGroup::fetch( $GroupID );
    $GroupName = $groupInfo->attribute("name");
    $tpl->setVariable( "group_name", $GroupName );
}

$tpl->setVariable( "module", $Module );

$Result =& $tpl->fetch( "design:class/classlist.tpl" );

?>
