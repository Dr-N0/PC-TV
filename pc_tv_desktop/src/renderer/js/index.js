let login_page = document.getElementById("login-section");
let search_page = document.getElementById("search-section");
let connected_page = document.getElementById("connected-section");
let current_page = "login";
let logged_in, register = false;

let login_form = document.getElementById("login-form");
let login_form_submit = document.getElementById("login-form-submit");
let search_button = document.getElementById("search-btn");
let toggle_register_button = document.getElementById("toggle_register_button");
let toggle_login_button = document.getElementById("toggle_login_button");
let display = document.querySelector('.error')

// Authenticate user
login_form.addEventListener("submit", async (e) => {
  e.preventDefault();
  const username = login_form.username.value;
  const password = login_form.password.value;
  if(register == true){
    e.preventDefault()
    display.textContent = ''

    try {
      const res = await fetch('http://localhost:5000/api/auth/register', {
        method: 'POST',
        body: JSON.stringify({ "username": username, "password": password }),
        headers: { 'Content-Type': 'application/json' }
      })

      const data = await res.json();

      if(res.status === 400 || res.status === 401){
        return display.textContent = `${data.message}. ${data.error ? data.error : ''}`
      }

      logged_in = true;
      load_search_page();
    } catch (err) {
      console.log(err.message)
    }
  } else if (register == false){
    display.textContent = ''

    try {
      const res = await fetch('http://localhost:5000/api/auth/login', {
        method: 'POST',
        body: JSON.stringify({ "username": username, "password": password }),
        headers: { 'Content-Type': 'application/json' }
      })

      const data = await res.json();

      if (res.status === 400 || res.status === 401) {
        return display.textContent = `${data.message}. ${data.error ? data.error : ''}`
      }

      logged_in = true;
      load_search_page();
    } catch (err) {
      console.log(err.message)
    }
  } else {
    console.log("Can't log in");
  }
})

search_button.addEventListener("click", (e) => {
  e.preventDefault();
  
  load_connected_page();
})

function toggle_sign_in(e) {
  if(e == "register"){
    register = true;
    login_form_submit.value = "Register";
    toggle_register_button.classList.toggle("hidden");
    toggle_login_button.classList.toggle("hidden");
  } else if (e == "login"){
    register = false;
    login_form_submit.value = "Log In";
    toggle_register_button.classList.toggle("hidden");
    toggle_login_button.classList.toggle("hidden");
  }
}

function load_login_page() {
  if(current_page != "login" && logged_in == false) {
      hide_all_pages();
      login_page.classList.remove("hidden");
      current_page = "login";

      login_page.classList.add("animate-in");
      setTimeout(() => {
        login_page.classList.remove("animate-in");
      }, 1500)
  }
}

function load_search_page() {
  if(current_page != "search" && logged_in == true) {
      hide_all_pages();
      search_page.classList.remove("hidden");
      current_page = "search";

      search_page.classList.add("animate-in");
      setTimeout(() => {
        search_page.classList.remove("animate-in");
      }, 1500)
  }
}

function load_connected_page() {
  if(current_page != "connected" && logged_in == true) {
      hide_all_pages();
      connected_page.classList.remove("hidden");
      current_page = "connected";

      connected_page.classList.add("animate-in");
      setTimeout(() => {
        connected_page.classList.remove("animate-in");
      }, 1500)
  }
}

/**
 * display = None to all of the pages and outer containers for pages.
 * @function
 */
function hide_all_pages() {
  login_page.classList.add("hidden");
  search_page.classList.add("hidden");
  connected_page.classList.add("hidden");
}