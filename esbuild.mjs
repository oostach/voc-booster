import esbuild from "esbuild";
import { sassPlugin } from "esbuild-sass-plugin";
import postcss from 'postcss';
import autoprefixer from 'autoprefixer';

// Generate CSS/JS Builds
let ctx = await esbuild.context({
      entryPoints: [
        { out: 'application', in: "app/assets/stylesheets/application.scss" },
        { out: 'application', in: "app/javascript/application.js" },
      ],
      outdir: "app/assets/builds",
      bundle: true,
      metafile: true,
      target: 'es2020',
      sourcemap: true,
      minify: false,
      loader: { '.ts': 'ts' },
      publicPath: '/assets',
      plugins: [
          sassPlugin({
              async transform(source) {
                  const { css } = await postcss([autoprefixer]).process(source, { from: undefined });
                  return css;
              },
          }),
      ],
  });

await ctx.watch()
  .then(() => console.log("⚡ Build complete! ⚡"))
  .catch(() => process.exit(1));
