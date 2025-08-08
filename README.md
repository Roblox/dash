# Dash

<div>
	<a href="https://github.com/Roblox/jest-roblox-internal/actions?query=workflow%3ACI">
		<img src="https://github.com/Roblox/jest-roblox-internal/workflows/CI/badge.svg" alt="GitHub Actions Build Status" />
	</a>
	<a href="https://roblox.github.io/jest-roblox-internal/">
			<img src="https://img.shields.io/badge/docs-website-green.svg" alt="Documentation" />
	</a>
	<a href='https://coveralls.io/github/Roblox/jest-roblox-internal'>
		<img src='https://coveralls.io/repos/github/Roblox/jest-roblox-internal/badge.svg?t=4czPqO&kill_cache=1' alt='Coverage Status' />
	</a>
</div>

A collection of core utilities expanding the capabilities of Luau in Roblox.

[Read the docs](https://roblox.github.io/dash-internal/)

## Usage

Add this package to `dependencies` section in your `rotriever.toml`, for example:
```toml
Dash = "3.0.0"
```

Then, require anything you need from `Dash`:

```luau
local Dash = require(Packages.Dash)
local map = Dash.map
```

## License
Dash is available under the MIT license. See [LICENSE](LICENSE.txt) for details.
