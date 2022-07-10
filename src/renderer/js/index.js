let login_page = document.getElementById("login-section");
let search_page = document.getElementById("search-section");
let connected_page = document.getElementById("connected-section");
let current_page = "login";

const loginForm = document.getElementById("login-form");
const loginButton = document.getElementById("login-form-submit");
const loginErrorMsg = document.getElementById("login-error-msg");

// Authenticate user
loginButton.addEventListener("click", (e) => {
  e.preventDefault();
  const username = loginForm.username.value;
  const password = loginForm.password.value;

  if (username === "user" && password === "web_dev") {
      load_search_page();
  }
})

function load_login_page() {
  if(current_page != "login") {
      hide_all_pages();
      login_page.classList.remove("hidden");
      current_page = "login";

      login_page.classList.add("animate-in")
      setTimeout(() => {
        login_page.classList.remove("animate-in");
      }, 1500)
  }
}

function load_search_page() {
  if(current_page != "search") {
      hide_all_pages();
      search_page.classList.remove("hidden");
      current_page = "search";

      search_page.classList.add("animate-in")
      setTimeout(() => {
        search_page.classList.remove("animate-in");
      }, 1500)
  }
}

function load_connected_page() {
  if(current_page != "connected") {
      hide_all_pages();
      connected_page.classList.remove("hidden");
      current_page = "connected";

      connected_page.classList.add("animate-in")
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