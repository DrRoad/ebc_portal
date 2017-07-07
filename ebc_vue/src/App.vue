<template>
  <div id="app" class="container-fluid">
    <div class = "jumbotron banner-portal">
      <div class="row align-items-center">

        <div class="col col-xs-6" align="left">
          <div class="hcon">
            <h1>
              <div>
                <strong>EVIDENCE FOR NATURE AND PEOPLE</strong>
              </div>
            </h1>
            <p>
              </p><div style="color:#F9CC0F;font-size:30px">
                <em>DATA PORTAL</em>
              </div>
            <p></p>
          </div>
        </div>
        <div class="col col-xs-6 hidden-sm-down" align="right">
          <a href="http://www.snappartnership.net/">
            <img src="./assets/snap-acronym-color-white.png" alt="snap partnership logo" height="75px">
          </a>
        </div>

      </div>
      <div class="row align-items-center justify-content-end hidden-md-up">
        <div class = "col-8" style="background-color: rgb(131,146,143);">
          <a href="http://www.snappartnership.net/">
            <svg viewBox="0,0,290,75" style="max-height:75px; max-width:290px; min-width:100px;">
              <image xlink:href="./assets/snap-acronym-color-white.png" x="0" y="0" height="75px" width="290px"/>
            </svg>
          </a>
        </div>
      </div>
    </div>
    <nav class="navbar navbar-toggleable-sm navbar-light nb-main" role="navigation">
      <div class = "container">
        <div class="navbar-header" style="width:130px;">
          <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#nb-main-collapse" aria-controls="navbarSupportedContentMain" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <a class="navbar-brand" href="#">Home</a>
        </div>
        <div class="collapse navbar-collapse" id="nb-main-collapse">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item dropdown">  
              <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">ABOUT</a>
              <div class="dropdown-menu">
                <a class="dropdown-item" href="#">The Method</a>
                <a class="dropdown-item" href="#">The Data &amp; Tool</a>
                <a class="dropdown-item" href="#">The Group</a>
              </div>
            </li>
            <li class="nav-item dropdown">  
              <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">EXPLORE BY</a>
              <div class="dropdown-menu">
                <a class="dropdown-item" href="#">Evidence Map</a>
                <a class="dropdown-item" href="#">Linkage Explorer</a>
                <a class="dropdown-item" href="#">Dashboard</a>
              </div>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">NEWS</a>
            </li>
            <li class="nav-item dropdown">  
              <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">RESEARCH</a>
              <div class="dropdown-menu">
                <a class="dropdown-item" href="#">Ongoing syntheses/maps</a>
              </div>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">CONTACT</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">USER REGISTRATION</a>
            </li>
          </ul>

        </div>
      </div>
    </nav>
  </div>
</template>

<script>
export default {
  name: 'app',
  data: function () {
    return {
      msg: 'Welcome to Your Vue.js App'
    }
  }
}
</script>

<style>
  @import url("https://fonts.googleapis.com/css?family=Lato:400,700,400italic");
  body {
    font-family: "Lato", "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size: 15px;
    line-height: 1.42857143;
  }

  .banner-portal {
    background-image: url('assets/header2_test.png');
    background-repeat: no-repeat;
    background-position: 25% 20%;
    margin-bottom: 0px;
    padding-top: 0px;
    border-radius: 0px;
    background-color: rgb(131,146,143);
  }

  .banner-portal .hcon {
    background-color: rgba(0, 0, 0, 0.5);
    padding: 20px;
    margin-top: 20px;
  }

  .banner-portal .hcon h1 {
    color: #fff;
    margin-bottom: 20px;
  }

  .nb-main {
    background-color: #44CDB5;
    font-size: 90%;
  }
  .nb-main > .container > .navbar-header  .navbar-brand, #nb-main-collapse > ul a  {
    color: #fff;
  }
  #nb-main-collapse .dropdown-menu > a {
    color: #7b8a8b;
  }
</style>