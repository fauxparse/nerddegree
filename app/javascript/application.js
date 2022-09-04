// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("./channels");

window.$ = window.jQuery = require("jquery");

require("jquery-ui");
require("blueimp-file-upload");

$(() => {
  $("#file-upload").each((_, el) => {
    const input = $(el);

    $(el).fileupload({
      fileUpload: input,
      url: input.data("url"),
      type: "POST",
      autoUpload: true,
      formData: input.data("formdata"),
      paramName: "file",
      dataType: "XML",
      replaceFileInput: false,

      progressall: (e, data) => {
        $("[type=submit]").attr("disabled", true);
        const progress = (data.loaded / data.total) * 100;
        $(".upload.progress")
          .show()
          .find(".bar")
          .css({ width: `${progress}%` });
      },

      done: (e, data) => {
        const url = $(data.jqXHR.responseXML)
          .find("Location")
          .text()
          .replace(/^https/, "http");
        $("#episode_url").val(unescape(url));
        $("#episode_size").val(data.total);
        $("[type=submit]").removeAttr("disabled");
      },

      fail: (e, data) => {
        // TODO: handle gracefully
      },
    });
  });
});

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
