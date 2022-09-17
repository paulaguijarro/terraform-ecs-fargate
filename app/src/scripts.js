var ref;
const GIFS = [
  "https://media2.giphy.com/media/isT304mEdP1y8/giphy.gif?cid=e66566f736ed5c6e1af38ff20049f47a7a43839cdd0c3612&rid=giphy.gif&ct=g",
  "https://media2.giphy.com/media/qMLQ2EOUzMT84/giphy.gif?cid=e66566f78be34db06427e5e2db7187cc0079005ac5788297&rid=giphy.gif&ct=g",
  "https://media0.giphy.com/media/dRyXC8ICV1LsUlz4dF/giphy.gif?cid=e66566f71cb0b3aa069d680d334998757e5a20ab587d1520&rid=giphy.gif&ct=g",
  "https://media4.giphy.com/media/3oEduOfBRMpUnmhyRG/giphy.gif?cid=e66566f74bd88d496e92d3e996f9e83c85520e4c0dc87e13&rid=giphy.gif&ct=g",
  "https://media4.giphy.com/media/vVegyymxA90fkY8jkE/giphy.gif?cid=e66566f72c135d7dec29dcaca477ccf615ae027ad9327c7d&rid=giphy.gif&ct=g",
  "https://media0.giphy.com/media/jS6sVMK2fu4Uw/giphy.gif?cid=e66566f775b5c84a70cb062a7c45de95f425d6cf4cb0f3db&rid=giphy.gif&ct=g",
  "https://media3.giphy.com/media/5PIg7wgr9xQkM/giphy.gif?cid=e66566f70d1beb4b0349cbd0d18b87700f35086ed5c44e42&rid=giphy.gif&ct=g",
  "https://media4.giphy.com/media/spqpmEmXo7TdndZQoA/giphy.gif?cid=e66566f784f3ef4e96308547fbf7378d5841079f648a4c4a&rid=giphy.gif&ct=g",
  "https://media3.giphy.com/media/vRD9d4wYnS9na/giphy.gif?cid=e66566f7602976e24750b4b4abae682883591f4980122784&rid=giphy.gif&ct=g",
  "https://media0.giphy.com/media/m7ZFt0RdB7Pz2/giphy.gif?cid=e66566f763f625ebd997d3bdbd4b616562c0c5d61230a1ba&rid=giphy.gif&ct=g",
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
