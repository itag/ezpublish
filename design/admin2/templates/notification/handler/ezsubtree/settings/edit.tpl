{let item_type=ezpreference( 'admin_list_limit' )
     number_of_items=min( $item_type, 3)|choose( 10, 10, 25, 50 )
     subscribed_nodes=fetch( 'notification', 'subscribed_nodes', hash( 'limit', $number_of_items, 'offset', $view_parameters.offset ) )
     subscribed_nodes_count=fetch( 'notification', 'subscribed_nodes_count')}
<div class="context-block">
{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
<h2 class="context-title">{'My item notifications [%notification_count]'|i18n( 'design/admin/notification/handler/ezsubtree/settings/edit',, hash( '%notification_count', $subscribed_nodes_count ) )}</h2>

{* DESIGN: Mainline *}<div class="header-subline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

{section show=$subscribed_nodes}
{* Items per page *}
<div class="context-toolbar">
<div class="block">
<div class="left">
<p>
    {switch match=$number_of_items}
    {case match=25}
        <a href={'/user/preferences/set/admin_list_limit/1/notification/settings'|ezurl}>10</a>
        <span class="current">25</span>
        <a href={'/user/preferences/set/admin_list_limit/3/notification/settings'|ezurl}>50</a>
    {/case}

    {case match=50}
        <a href={'/user/preferences/set/admin_list_limit/1/notification/settings'|ezurl}>10</a>
        <a href={'/user/preferences/set/admin_list_limit/2/notification/settings'|ezurl}>25</a>
        <span class="current">50</span>
    {/case}

    {case}
        <span class="current">10</span>
        <a href={'/user/preferences/set/admin_list_limit/2/notification/settings'|ezurl}>25</a>
        <a href={'/user/preferences/set/admin_list_limit/3/notification/settings'|ezurl}>50</a>
    {/case}
    {/switch}
</p>
</div>
<div class="break"></div>
</div>
</div>

<table class="list" cellspacing="0">
<tr>
    <th class="tight"><img src={'toggle-button-16x16.gif'|ezimage} alt="{'Invert selection.'|i18n( 'design/admin/notification/handler/ezsubtree/settings/edit' )}" title="{'Invert selection.'|i18n( 'design/admin/notification/handler/ezsubtree/settings/edit' )}" onclick="ezjs_toggleCheckboxes( document.notification, 'SelectedRuleIDArray_{$handler.id_string}[]' ); return false;" /></th>
    <th>{'Name'|i18n( 'design/admin/notification/handler/ezsubtree/settings/edit' )}</th>
    <th>{'Type'|i18n( 'design/admin/notification/handler/ezsubtree/settings/edit' )}</th>
    <th>{'Section'|i18n( 'design/admin/notification/handler/ezsubtree/settings/edit' )}</th>
</tr>

{section var=Rules loop=$subscribed_nodes sequence=array( bglight, bgdark )}
<tr class="{$Rules.sequence}">
    <td><input type="checkbox" name="SelectedRuleIDArray_{$handler.id_string}[]" value="{$Rules.item.id}" title="{'Select item for removal.'|i18n( 'design/admin/notification/handler/ezsubtree/settings/edit' )}" /></td>
    <td>{$Rules.item.node.class_identifier|class_icon( small, $Rules.item.node.class_name )}&nbsp;<a href={concat( '/content/view/full/', $Rules.item.node.node_id, '/' )|ezurl}>{$Rules.item.node.name|wash}</a></td>
    <td>{$Rules.item.node.object.content_class.name|wash}</td>
    <td>{let section_object=fetch( section, object, hash( section_id, $Rules.item.node.object.section_id ) )}{section show=$section_object}{$section_object.name|wash}{section-else}<i>{'Unknown'|i18n( 'design/admin/notification/handler/ezsubtree/settings/edit' )}</i>{/section}{/let}</td>
</tr>
{/section}
</table>

<div class="context-toolbar">
{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri='/notification/settings'
         item_count=$subscribed_nodes_count
         view_parameters=$view_parameters
         item_limit=$number_of_items}
</div>

{section-else}
<div class="block">
<p>{'You have not subscribed to receive notifications about any items.'|i18n( 'design/admin/notification/handler/ezsubtree/settings/edit' )}</p>
</div>
{/section}

{* DESIGN: Content END *}</div></div></div>

<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
    <div class="block">
        {if $subscribed_nodes}
        <input class="button" type="submit" name="RemoveRule_{$handler.id_string}" value="{'Remove selected'|i18n( 'design/admin/notification/handler/ezsubtree/settings/edit' )}" title="{'Remove selected items.'|i18n( 'design/admin/notification/handler/ezsubtree/settings/edit' )}" />
        {else}
        <input class="button-disabled" type="submit" name="RemoveRule_{$handler.id_string}" value="{'Remove selected'|i18n( 'design/admin/notification/handler/ezsubtree/settings/edit' )}" disabled="disabled" />
        {/if}

        <input class="button" type="submit" name="NewRule_{$handler.id_string}" value="{'Add items'|i18n( 'design/admin/notification/handler/ezsubtree/settings/edit' )}" title="{'Add items to your personal notification list.'|i18n( 'design/admin/notification/handler/ezsubtree/settings/edit' )}" />
    </div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div>

</div>
{/let}