<div id="content-tree">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

{if ezpreference( 'admin_treemenu' )}
<h4><a class="showhide" href={'/user/preferences/set/admin_treemenu/0'|ezurl} title="{'Hide content structure.'|i18n( 'design/admin/parts/content/menu' )}"><span class="bracket">[</span>-<span class="bracket">]</span></a> {'Content structure'|i18n( 'design/admin/parts/content/menu' )}</h4>
{else}
<h4><a class="showhide" href={'/user/preferences/set/admin_treemenu/1'|ezurl} title="{'Show content structure.'|i18n( 'design/admin/parts/content/menu' )}"><span class="bracket">[</span>+<span class="bracket">]</span></a> {'Content structure'|i18n( 'design/admin/parts/content/menu' )}</h4>
{/if}

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-bl"><div class="box-br"><div class="box-content">

{* Treemenu. *}
<div id="contentstructure">

{if ezpreference( 'admin_treemenu' )}
    {if ezini('TreeMenu','Dynamic','contentstructuremenu.ini')|eq('enabled')}
        {include uri='design:contentstructuremenu/content_structure_menu_dynamic.tpl'}
    {else}
        {include uri='design:contentstructuremenu/content_structure_menu.tpl'}
    {/if}
{/if}
</div>

{* Trashcan. *}
{if ne( $ui_context, 'browse' )}
<div id="trash">
<ul>
    <li><img src={'trash-icon-16x16.gif'|ezimage} width="16" height="16" alt="{'Trash'|i18n( 'design/admin/parts/content/menu' )}" />&nbsp;<a href={concat( '/content/trash/', ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )|ezurl} title="{'View and manage the contents of the trash bin.'|i18n( 'design/admin/parts/content/menu' )}">{'Trash'|i18n( 'design/admin/parts/content/menu' )}</a></li>
</ul>
</div>
{/if}

{* Left menu width control. *}
<div class="widthcontrol">
<p>
{switch match=ezpreference( 'admin_left_menu_width' )}
{case match='medium'}
<a href={'/user/preferences/set/admin_left_menu_width/small'|ezurl} title="{'Change the left menu width to small size.'|i18n( 'design/admin/parts/content/menu' )}">{'Small'|i18n( 'design/admin/parts/content/menu' )}</a>
<span class="current">{'Medium'|i18n( 'design/admin/parts/content/menu' )}</span>
<a href={'/user/preferences/set/admin_left_menu_width/large'|ezurl} title="{'Change the left menu width to large size.'|i18n( 'design/admin/parts/content/menu' )}">{'Large'|i18n( 'design/admin/parts/content/menu' )}</a>
{/case}

{case match='large'}
<a href={'/user/preferences/set/admin_left_menu_width/small'|ezurl} title="{'Change the left menu width to small size.'|i18n( 'design/admin/parts/content/menu' )}">{'Small'|i18n( 'design/admin/parts/content/menu' )}</a>
<a href={'/user/preferences/set/admin_left_menu_width/medium'|ezurl} title="{'Change the left menu width to medium size.'|i18n( 'design/admin/parts/content/menu' )}">{'Medium'|i18n( 'design/admin/parts/content/menu' )}</a>
<span class="current">{'Large'|i18n( 'design/admin/parts/content/menu' )}</span>
{/case}

{case}
<span class="current">{'Small'|i18n( 'design/admin/parts/content/menu' )}</span>
<a href={'/user/preferences/set/admin_left_menu_width/medium'|ezurl} title="{'Change the left menu width to medium size.'|i18n( 'design/admin/parts/content/menu' )}">{'Medium'|i18n( 'design/admin/parts/content/menu' )}</a>
<a href={'/user/preferences/set/admin_left_menu_width/large'|ezurl} title="{'Change the left menu width to large size.'|i18n( 'design/admin/parts/content/menu' )}">{'Large'|i18n( 'design/admin/parts/content/menu' )}</a>
{/case}
{/switch}
</p>
</div>

{* DESIGN: Content END *}</div></div></div></div></div></div>

</div>

{* See parts/ini_menu.tpl and menu.ini for more info, or parts/setup/menu.tpl for full example *}
{include uri='design:parts/ini_menu.tpl' ini_section='Leftmenu_content'}
