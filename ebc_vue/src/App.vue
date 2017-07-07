<template>
  <div id="app" class="container-fluid">
    <div class = "jumbotron banner-portal">
      <div class="row align-items-center">

        <div class="col col-sm-8" align="left">
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
        <div class="col col-sm-4" align="right">
          <a href="http://www.snappartnership.net/">
            <img src="./assets/snap-acronym-color-white.png" height="75">
          </a>
          <br>
        </div>

      </div>
    </div>
    <nav class="navbar navbar-toggleable-sm navbar-default navbar-light bg-faded nb-main" role="navigation">
      <div class = "container">
        <div class="navbar-header">
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
  data () {
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
    background-image: url('./assets/header2_test.png');
    background-repeat: no-repeat;
    background-position: 25% 20%;
    margin-bottom: 0px;
    border-radius: 0px;
  }

  .banner-portal .hcon {
    background-color: rgba(0, 0, 0, 0.5);
    padding: 20px;
  }

  .banner-portal .hcon h1 {
    color: #fff;
    margin-bottom: 20px;
  }

  .nb-main {
    background-color: #44CDB5;
  }
  .nb-main > .container > .navbar-header  .navbar-brand, #nb-main-collapse > ul a  {
    color: #fff;
  }
  #nb-main-collapse .dropdown-menu > a {
    color: #7b8a8b;
  }
</style>