<#assign
known = Session.SPRING_SECURITY_CONTEXT??
>

<#if known>
    <#assign
    USER = Session.SPRING_SECURITY_CONTEXT.authentication.principal
    NAME = USER.getUsername()
    CURRENT_USER_ID = USER.getId()
    >
<#else >
    <#assign
    NAME = "Guest"
    CURRENT_USER_ID = -1
    >
</#if>