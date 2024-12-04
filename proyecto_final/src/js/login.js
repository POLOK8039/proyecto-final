const leftDiv = document.getElementById('leftDiv');
const rightDiv = document.getElementById('rightDiv');
const link = document.getElementById('link');
const toggleImage = document.getElementById('toggleImage');
const toggleText = document.getElementById('toggleText');
const paragraph = document.getElementById('paragraph');
const msg = document.getElementById('msg').getAttribute('data-msg');
const images = [
    '/src/svg/closed-lock.svg',
    '/src/svg/user.svg'
];
link.addEventListener('click', event => {
    event.preventDefault();
    leftDiv.style.opacity = '0';
    rightDiv.style.opacity = '0';
    leftDiv.classList.toggle('swapped');
    rightDiv.classList.toggle('swapped-right');
    setTimeout(() => {
        const isLogin = leftDiv.classList.contains('swapped');
        rightDiv.innerHTML = isLogin
            ?`
            <form action="" method="post">
                <h2>Request your code!</h2>

                <!--<p>We will send instructions to your email.</p>-->
                <!-- <input id="email" name="email" class="form-control" type="email"  autocomplete="off" required placeholder="Enter your email">
                <input id="confirm-email" name=" confirm-email" class="form-control" type="email" autocomplete="off" required placeholder="Confirm your email">

                <button type="submit" class="btn-primary">Next step</button> -->

                <div class="form-control" style="margin: 10% 0px 10% 5%;">
                <h3>Direct your supervisor to request your username or password</h3>
                <p>You will be attended to as soon as possible, thank you!</p>
                </div>
                
                
            </form>
            ` : `
            <form action="" method="post">
                <h2>Welcome back!</h2>
                <p>${msg}</p>
                <input id="username" name="username" class="form-control" type="text"  autocomplete="off" required placeholder="User">
                <input id="password" name="password" class="form-control" type="password" autocomplete="off" required placeholder="Password">
                <button type="submit" class="btn-primary">Login</button>
            </form>
            `;
        toggleImage.src = images[+isLogin];
        toggleText.textContent = isLogin ? 'Already have an account?' : 'Forgot password?';
        paragraph.textContent = isLogin ? 'Select the icon to login' : 'Select the icon for more information';
        leftDiv.style.opacity = '1';
        rightDiv.style.opacity = '1';
    }, 800);
});