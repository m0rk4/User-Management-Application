<#macro userForm path name>

    <div class="row">
        <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
            <div class="card my-5">
                <div class="card-body">
                    <h5 class="card-title text-center">
                        <#if name == "login">
                            Sign in
                        <#else>
                            Sign up
                        </#if></h5>
                    <form method="post" action="${path}">

                        <hr class="my-4">

                        <div class="form-label-group my-4">
                            <input type="text"
                                   name="username"
                                   class="form-control ${(usernameError??)?string('is-invalid','')}"
                                   placeholder="Username" autofocus>
                            <#if usernameError??>
                                <div class="invalid-feedback">
                                    ${usernameError}
                                </div>
                            </#if>
                        </div>

                        <div class="form-label-group my-4">
                            <input type="password"
                                   name="password"
                                   class="form-control ${(passwordError??)?string('is-invalid','')}"
                                   placeholder="Password">
                            <#if passwordError??>
                                <div class="invalid-feedback">
                                    ${passwordError}
                                </div>
                            </#if>
                        </div>

                        <#if name == "registration">
                            <div class="form-label-group my-4">
                                <input type="email"
                                       name="email"
                                       class="form-control ${(emailError??)?string('is-invalid','')}"
                                       placeholder="Email address">
                                <#if emailError??>
                                    <div class="invalid-feedback">
                                        ${emailError}
                                    </div>
                                </#if>
                            </div>
                        <#else >
                            <div>
                                <a href="/registration">Register</a>
                            </div>
                        </#if>

                        <input type="hidden" name="_csrf" value="${_csrf.token}">

                        <button class="btn btn-lg btn-primary btn-block mt-2" type="submit">
                            <#if name == "login">
                                Login
                            <#else>
                                Register
                            </#if>
                        </button>

                    </form>
                </div>
            </div>
        </div>
    </div>

</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" class="btn btn-primary">Logout</button>
    </form>
</#macro>