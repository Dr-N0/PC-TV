let login_page = document.getElementById("login-section");
let search_page = document.getElementById("search-section");
let connected_page = document.getElementById("connected-section");
let current_page = "login";
let logged_in = false;

let login_form = document.getElementById("login-form");
let search_button = document.getElementById("search-btn");

// Authenticate user
login_form.addEventListener("submit", (e) => {
  e.preventDefault();
  const username = login_form.username.value;
  const password = login_form.password.value;

  if (username === "u" && password === "p") {
    logged_in = true;
    load_search_page();
  }
})

search_button.addEventListener("click", (e) => {
  e.preventDefault();
  
  // load_connected_page();
})

function searchForDevice() {
  window.bridge.searchForDevice();
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