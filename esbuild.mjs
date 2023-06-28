import esbuild from "esbuild";
import { sassPlugin } from "esbuild-sass-plugin";
import postcss from 'postcss';
import autoprefixer from 'autoprefixer';

let config = {
  entryPoints: [
    { out: 'application', in: "app/assets/stylesheets/application.scss" },
    { out: 'session', in: "app/assets/stylesheets/session.scss" },
    { out: 'application', in: "app/javascript/application.js" },
  ],
  outdir: "app/assets/builds",
  bundle: true,
  metafile: true,
  target: 'es2020',
  sourcemap: true,
  minify: process.env.RAILS_ENV != "development",
  loader: {
    '.ts': 'ts',
    '.tsx': 'tsx',
    '.ttf': 'dataurl'
  },
  publicPath: '/assets',
  plugins: [
    sassPlugin({
      async transform(source) {
        const { css } = await postcss([autoprefixer]).process(source, { from: undefined });
        return css;
      },
    }),
  ],
};

// Generate CSS/JS Builds
if (process.env.RAILS_ENV == "development") {
  let ctx = await esbuild.context(config);
  await ctx.watch()
    .then(() => console.log("⚡ Build complete! ⚡"))
    .catch(() => process.exit(1));
} else {
  await esbuild.build(config)
    .then(() => console.log("⚡ Build complete! ⚡"))
    .catch(() => process.exit(1));
}
