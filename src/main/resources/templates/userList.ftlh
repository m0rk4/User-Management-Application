<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.common>
    <div class="jumbotron jumbotron-fluid">
        <div class="container">
            <h1 class="display-4">Mastering Spring!</h1>
            <p class="lead">This is the 4th task, Web Application</p>
        </div>
    </div>

    <form action="/main" method="post">

        <div class="d-flex justify-content-center mb-5">
            <div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
                <div class="btn-group btn-group-lg" role="group" aria-label="First group">
                    <button type="submit" class="btn btn-primary" name="block">Block</button>
                    <button type="submit" class="btn btn-primary" name="unblock">
                        <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-unlock" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" d="M9.655 8H2.333c-.264 0-.398.068-.471.121a.73.73 0 0 0-.224.296 1.626 1.626 0 0 0-.138.59V14c0 .342.076.531.14.635.064.106.151.18.256.237a1.122 1.122 0 0 0 .436.127l.013.001h7.322c.264 0 .398-.068.471-.121a.73.73 0 0 0 .224-.296 1.627 1.627 0 0 0 .138-.59V9c0-.342-.076-.531-.14-.635a.658.658 0 0 0-.255-.237A1.122 1.122 0 0 0 9.655 8zm.012-1H2.333C.5 7 .5 9 .5 9v5c0 2 1.833 2 1.833 2h7.334c1.833 0 1.833-2 1.833-2V9c0-2-1.833-2-1.833-2zM8.5 4a3.5 3.5 0 1 1 7 0v3h-1V4a2.5 2.5 0 0 0-5 0v3h-1V4z"/>
                        </svg>
                    </button>
                    <button type="submit" class="btn btn-primary" name="delete">
                        <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                            <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                            <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                        </svg>
                    </button>
                </div>
            </div>
        </div>

        <table class="table table-black table-bordered">
            <thead class="table-primary">
            <tr>
                <th scope="col">
                    <div class="custom-control custom-checkbox">
                        <input type="checkbox" name="checkAll" class="custom-control-input" id="tableAllCheck">
                        <label class="custom-control-label" for="tableAllCheck"></label>
                    </div>
                </th>
                <th scope="col">
                    <div>#</div>
                </th>
                <th scope="col">
                    <div>Username</div>
                </th>
                <th scope="col">
                    <div>Email</div>
                </th>
                <th scope="col">
                    <div>Registration Date</div>
                </th>
                <th scope="col">
                    <div>Last authorization</div>
                </th>
                <th scope="col">
                    <div>Status</div>
                </th>
            </tr>
            </thead>
            <tbody>
            <#list users as user>
                <tr class="table-info">
                    <td>
                        <div class="custom-control custom-checkbox">
                            <input type="checkbox" name="${user.getId()}" about="def" class="custom-control-input" id="${user.getId()}">
                            <label class="custom-control-label" for="${user.getId()}"></label>
                        </div>
                    </td>
                    <td>${user.getId()}</td>
                    <td>${user.getUsername()}</td>
                    <td>${user.getEmail()}</td>
                    <td>${user.getRegistrationDate()}</td>
                    <td><#if user.getLastLogin()??>${user.getLastLogin()}<#else>Not authorized yet</#if></td>
                    <td>${(user.isEnabled())?string("Active", "Blocked")}</td>
                </tr>
            </#list>
            </tbody>
        </table>
        <input type="hidden" value="${_csrf.token}" name="_csrf">
    </form>

    <script>
        const others = document.querySelectorAll("input[about=def]");
        document.querySelector("input[name=checkAll]").addEventListener('change', function () {
            for (var i = 0; i < others.length; i++) others[i].checked = this.checked;
        });
    </script>
</@c.common>