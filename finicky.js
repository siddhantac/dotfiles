// ~/.finicky.js
export default {
  defaultBrowser: "Google Chrome",
  handlers: [
    {
      match: [
          "reddit.com/*",
          "youtube.com/*",
          "github.com/siddhantac",
          "github.com/siddhantac/*",
          "www.google.com/maps/*"
      ],
      browser: "Google Chrome:sid",
    },
      {
      match: [
          "github.com/deliveryhero/*",
      ],
      browser: "Google Chrome:foodpanda",
      },
  ],
};
