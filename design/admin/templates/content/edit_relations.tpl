{* DO NOT EDIT THIS FILE! Use an override template instead. *}

<div class="context-block" id="content-relation-items">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h2 class="context-title">{'Related objects [%related_objects]'|i18n( 'design/admin/content/edit',, hash( '%related_objects', $related_contentobjects|count ) )}</h2>

{* DESIGN: Subline *}<div class="header-subline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

{section show=$related_contentobjects|count|gt( 0 )}

    {* Related images *}
    {section show=$grouped_related_contentobjects.images|count|gt( 0 )}
    <h3>{'Related images [%related_images]'|i18n( 'design/admin/content/edit',, hash( '%related_images', $grouped_related_contentobjects.images|count ) )}</h3>
    <table class="list-thumbnails" cellspacing="0">
    <tr>

        {section var=RelatedImageObjects loop=$grouped_related_contentobjects.images}
        <td>
        <div class="image-thumbnail-item">
            {attribute_view_gui attribute=$RelatedImageObjects.item.data_map.image image_class=small}
            <p>
                <input type="checkbox" id="related-object-id-{$RelatedImageObjects.item.id}" name="DeleteRelationIDArray[]" value="{$RelatedImageObjects.item.id}" />
                {$RelatedImageObjects.item.name|wash}
           </p>
           <input class="linkbox" type="text" value="&lt;object id={$RelatedImageObjects.item.id} /&gt;" readonly="readonly" title="{'Copy this code and paste it into an XML field.'|i18n( 'design/admin/content/edit' )}" />
        </div>
        </td>
        {delimiter modulo=4}
        </tr><tr>
        {/delimiter}
        {/section}

    </tr>
    </table>

    {/section}



    {* Related files *}
    {section show=$grouped_related_contentobjects.files|count|gt( 0 )}
    <h3>{'Related files [%related_files]'|i18n( 'design/admin/content/edit',, hash( '%related_files', $grouped_related_contentobjects.files|count ) )}</h3>
        <div class="file-detail-list">

            <table class="list" cellspacing="0">
            <tr>
                <th>&nbsp;</th>
                <th class="name">{'Name'|i18n( 'design/admin/content/edit' )}</th>
                <th class="class">{'File type'|i18n( 'design/admin/content/edit' )}</th>
                <th class="filesize">{'Size'|i18n( 'design/admin/content/edit' )}</th>
                <th class="code">{'XML code'|i18n( 'design/admin/content/edit' )}</th>
            </tr>

            {section var=RelatedFileObjects loop=$grouped_related_contentobjects.files sequence=array( bglight, bgdark )}
                <tr class="{$RelatedFileObjects.sequence|wash}">
                    <td class="checkbox"><input type="checkbox" id="related-object-id-{$RelatedFileObjects.item.id}" name="DeleteRelationIDArray[]" value="{$RelatedFileObjects.item.id}" /></td>
                    <td class="name">{$RelatedFileObjects.item.class_name|class_icon( small, $RelatedFileObjects.class_name )}&nbsp;{$RelatedFileObjects.item.name|wash}</td>
                    <td class="filetype">{$RelatedFileObjects.item.data_map.file.content.mime_type|wash}</td>
                    <td class="filesize">{$RelatedFileObjects.item.data_map.file.content.filesize|si( byte )}</td>
                    <td class="code"><input class="linkbox" type="text" value="&lt;object id={$RelatedFileObjects.item.id} /&gt;" readonly="readonly" title="{'Copy this code and paste it into an XML field.'|i18n( 'design/admin/content/edit' )}" /></td>
                </tr>
            {/section}

            </table>
        </div>
    {/section}


    {* Related objects *}
    {section show=$grouped_related_contentobjects.objects|count|gt( 0 )}
    <h3>{'Related content [%related_objects]'|i18n( 'design/admin/content/edit',, hash( '%related_objects', $grouped_related_contentobjects.objects|count ) )}</h3>
        <div class="related-detail-list">

            <table class="list" cellspacing="0">
            <tr>
                <th>&nbsp;</th>
                <th class="name">{'Name'|i18n( 'design/admin/content/edit' )}</th>
                <th class="class">{'Type'|i18n( 'design/admin/content/edit' )}</th>
                <th class="code">{'XML code'|i18n( 'design/admin/content/edit' )}</th>
            </tr>

            {section var=RelatedObjects loop=$grouped_related_contentobjects.objects sequence=array( bglight, bgdark )}

                <tr class="{$RelatedObjects.sequence|wash}">
                    <td class="checkbox"><input type="checkbox" id="related-object-id-{$RelatedObjects.item.id}" name="DeleteRelationIDArray[]" value="{$RelatedObjects.item.id}" /></td>
                    <td class="name">{$RelatedObjects.item.class_name|class_icon( small, $RelatedObjects.class_name )}&nbsp;{$RelatedObjects.item.name|wash}</td>
                    <td class="class">{$RelatedObjects.item.class_name|wash}</td>
                    <td class="code"><input class="linkbox" type="text" value="&lt;object id={$RelatedObjects.item.id} /&gt;" readonly="readonly" title="{'Copy this code and paste it into an XML field.'i18n( 'design/admin/content/edit' )}" /></td>
                </tr>

            {/section}

            </table>
        </div>
    {/section}

{section-else}
<div class="block">
<p>{'There are no objects related to the one that is currently being edited.'|i18n( 'design/admin/content/edit' )}</p>
</div>
{/section}

{* DESIGN: Content END *}</div></div></div>

<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
<div class="block">

    {section show=$related_contentobjects}
    <input class="button" type="submit" name="DeleteRelationButton" value="{'Remove selected'|i18n( 'design/admin/content/edit' )}" title="{'Remove the selected items from the list(s) above. It is only the relations that will be removed. The items will not be deleted.'|i18n( 'design/admin/content/edit' )}" />
    {section-else}
    <input class="button-disabled" type="submit" name="DeleteRelationButton" value="{'Remove selected'|i18n( 'design/admin/content/edit' )}" disabled="disabled" />
    {/section}

    <input class="button" type="submit" name="BrowseObjectButton" value="{'Add existing'|i18n( 'design/admin/content/edit' )}" title="{'Add an existing item as a related object.'|i18n( 'design/admin/content/edit' )}" />
    <input class="button" type="submit" name="UploadFileRelationButton" value="{'Upload new'|i18n( 'design/admin/content/edit' )}" title="{'Upload a file and add it as a related object.'|i18n( 'design/admin/content/edit' )}" />
</div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div>

</div>
