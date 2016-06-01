    </div><!-- Main content end -->
    <div id="overlay"></div>
    <div id="loader">
      <style>
      #loader {
        background: #0f0f0f;
        color: #f1f1f1;
        position: fixed;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        text-align: center;
        z-index: 99998;
        -moz-transition: all 0.4s linear;
        -webkit-transition: all 0.4s linear;
        -o-transition: all 0.4s linear;
        transition: all 0.4s linear;
      }
      .ready.loaded #loader {
        opacity: 0;
      }
      #loader .spinner {
        width: 70px;
        height: 70px;
        margin: auto;
        position: absolute;
        left: 0;
        right: 0;
        top: 0;
        bottom: 0;
      }
      #loader .spinner.outer {
        fill: #fff;
        animation-name: rotateYcc;
        animation-duration: 1.5s;
        animation-iteration-count: infinite;
        animation-timing-function: ease-out;
        z-index: 1;
      }
      #loader .spinner.inner {
        fill: #ff1e53;
        animation-name: rotateY;
        animation-duration: 3s;
        animation-iteration-count: infinite;
        animation-timing-function: linear;
        z-index: 0;
      }
      @keyframes rotateY {
        from {transform: rotateY(0deg);}
        to {transform: rotateY(360deg);}
      }
      @keyframes rotateYcc {
        from {transform: rotateY(0deg);}
        to {transform: rotateY(-360deg);}
      }
      </style>
      <svg xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg" width="100.00006" height="100.00006" viewBox="0 0 100.00006 100.00006" version="1.1" class="spinner outer">
        <g transform="translate(0,0)">
          <path d="M 50 0 A 50 50 0 0 0 0 50 A 50 50 0 0 0 50 100 A 50 50 0 0 0 100 50 A 50 50 0 0 0 50 0 z M 50 9.2539062 A 40.74538 40.74538 0 0 1 90.746094 50 A 40.74538 40.74538 0 0 1 50 90.746094 A 40.74538 40.74538 0 0 1 9.2539062 50 A 40.74538 40.74538 0 0 1 50 9.2539062 z "/>
        </g>
      </svg>
      <svg xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg" width="100.00006" height="100.00006" viewBox="0 0 100.00006 100.00006" version="1.1" class="spinner inner">
        <g transform="translate(0,0)">
          <path d="M 50 30.394531 A 19.606142 19.606142 0 0 0 30.394531 50 A 19.606142 19.606142 0 0 0 50 69.605469 A 19.606142 19.606142 0 0 0 69.605469 50 A 19.606142 19.606142 0 0 0 50 30.394531 z M 50 45.056641 A 4.9436102 4.9436102 0 0 1 54.943359 50 A 4.9436102 4.9436102 0 0 1 50 54.943359 A 4.9436102 4.9436102 0 0 1 45.056641 50 A 4.9436102 4.9436102 0 0 1 50 45.056641 z " />
        </g>
      </svg>
    </div>

    <?php include('javascripts.tpl')?>
  </body>
</html>
