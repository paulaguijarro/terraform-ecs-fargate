var ref;
const GIFS = [
  "https://media.giphy.com/media/v6aOjy0Qo1fIA/giphy.gif",
  "https://media.giphy.com/media/8vQSQ3cNXuDGo/giphy.gif",
  "https://media.giphy.com/media/B7ppUExX92PjW/giphy.gif",
  "https://media.giphy.com/media/C23cMUqoZdqMg/giphy.gif",
  "https://media.giphy.com/media/2sbohai2TayStkrGgo/giphy.gif",
  "https://media.giphy.com/media/fAT2Db0j0Mblu/giphy.gif",
  "https://media.giphy.com/media/KHhs4BXpy5dba/giphy.gif",
  "https://media0.giphy.com/media/m7ZFt0RdB7Pz2/giphy.gif",
  "https://media3.giphy.com/media/vRD9d4wYnS9na/giphy.gif",
  "https://media.giphy.com/media/HMSLfCl5BsXoQ/giphy.gif",
];

function onLoad() {
  getGif();
  checkRefresh();
}

function checkRefresh() {
  if (document.cookie.includes("refresh=1")) {
    document.getElementById("check").checked = true;
    ref = setTimeout(function () {
      location.reload();
    }, 5000);
  } else {
  }
}

function changeCookie() {
  if (document.getElementById("check").checked) {
    document.cookie = "refresh=1;path=/";
    ref = setTimeout(function () {
      location.reload();
    }, 5000);
  } else {
    document.cookie = "refresh=0;path=/";
    clearTimeout(ref);
  }
}

function getGif() {
  var gifUrl = GIFS[Math.floor(Math.random() * GIFS.length)];
  const gifElement = document.getElementById("gif");
  gifElement.src = gifUrl;
  gifElement.style.opacity = 1;
}
