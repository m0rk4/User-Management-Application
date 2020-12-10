<#import "login.ftlh" as l>
<#include "security.ftlh">

<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #e3f2fd;">

    <a class="navbar-brand" href="/">Mastering Spring</a>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/main">Users Page</a>
            </li>
        </ul>

        <div class="navbar-text mr-3">${NAME}</div>
        <#if USER??>
            <@l.logout/>
        </#if>
    </div>
</nav>