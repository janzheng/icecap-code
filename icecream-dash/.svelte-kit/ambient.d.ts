
// this file is generated — do not edit it


/// <reference types="@sveltejs/kit" />

/**
 * Environment variables [loaded by Vite](https://vitejs.dev/guide/env-and-mode.html#env-files) from `.env` files and `process.env`. Like [`$env/dynamic/private`](https://kit.svelte.dev/docs/modules#$env-dynamic-private), this module cannot be imported into client-side code. This module only includes variables that _do not_ begin with [`config.kit.env.publicPrefix`](https://kit.svelte.dev/docs/configuration#env) _and do_ start with [`config.kit.env.privatePrefix`](https://kit.svelte.dev/docs/configuration#env) (if configured).
 * 
 * _Unlike_ [`$env/dynamic/private`](https://kit.svelte.dev/docs/modules#$env-dynamic-private), the values exported from this module are statically injected into your bundle at build time, enabling optimisations like dead code elimination.
 * 
 * ```ts
 * import { API_KEY } from '$env/static/private';
 * ```
 * 
 * Note that all environment variables referenced in your code should be declared (for example in an `.env` file), even if they don't have a value until the app is deployed:
 * 
 * ```
 * MY_FEATURE_FLAG=""
 * ```
 * 
 * You can override `.env` values from the command line like so:
 * 
 * ```bash
 * MY_FEATURE_FLAG="enabled" npm run dev
 * ```
 */
declare module '$env/static/private' {
	export const REDCAP_URL: string;
	export const REDCAP_API_KEY: string;
	export const NVM_INC: string;
	export const MANPATH: string;
	export const npm_package_devDependencies_radix_icons_svelte: string;
	export const npm_package_dependencies_bits_ui: string;
	export const TERM_PROGRAM: string;
	export const npm_package_devDependencies__yawnxyz_sheetlog: string;
	export const NODE: string;
	export const INIT_CWD: string;
	export const NVM_CD_FLAGS: string;
	export const npm_config_version_git_tag: string;
	export const TERM: string;
	export const SHELL: string;
	export const npm_package_devDependencies_vite: string;
	export const HOMEBREW_REPOSITORY: string;
	export const TMPDIR: string;
	export const npm_config_init_license: string;
	export const TERM_PROGRAM_VERSION: string;
	export const npm_package_dependencies_tailwind_variants: string;
	export const npm_package_devDependencies_sqids: string;
	export const npm_package_devDependencies_postcss_load_config: string;
	export const npm_package_scripts_dev: string;
	export const TERM_SESSION_ID: string;
	export const npm_package_dependencies_lucide_svelte: string;
	export const npm_package_devDependencies__sveltejs_kit: string;
	export const npm_package_private: string;
	export const npm_config_registry: string;
	export const npm_package_dependencies_formsnap: string;
	export const npm_package_readmeFilename: string;
	export const NVM_DIR: string;
	export const USER: string;
	export const npm_package_description: string;
	export const npm_package_devDependencies_dotenv: string;
	export const npm_package_devDependencies__unovis_ts: string;
	export const npm_package_devDependencies_svelte_headless_table: string;
	export const SSH_AUTH_SOCK: string;
	export const __CF_USER_TEXT_ENCODING: string;
	export const npm_package_devDependencies_postcss: string;
	export const npm_execpath: string;
	export const npm_package_devDependencies_svelte: string;
	export const npm_package_dependencies_tailwind_merge: string;
	export const PATH: string;
	export const npm_config_argv: string;
	export const npm_package_scripts_commit: string;
	export const _: string;
	export const LaunchInstanceID: string;
	export const npm_config_engine_strict: string;
	export const __CFBundleIdentifier: string;
	export const npm_package_devDependencies_d3_scale: string;
	export const PWD: string;
	export const npm_package_devDependencies_tailwindcss: string;
	export const npm_package_devDependencies__unovis_svelte: string;
	export const npm_package_scripts_preview: string;
	export const npm_lifecycle_event: string;
	export const LANG: string;
	export const npm_package_name: string;
	export const npm_package_scripts_build: string;
	export const npm_config_version_commit_hooks: string;
	export const XPC_FLAGS: string;
	export const npm_config_bin_links: string;
	export const XPC_SERVICE_NAME: string;
	export const npm_package_devDependencies__sveltejs_adapter_auto: string;
	export const npm_package_version: string;
	export const npm_package_devDependencies_autoprefixer: string;
	export const HOME: string;
	export const SHLVL: string;
	export const npm_package_type: string;
	export const npm_config_save_prefix: string;
	export const npm_config_strict_ssl: string;
	export const HOMEBREW_PREFIX: string;
	export const npm_config_version_git_message: string;
	export const npm_package_devDependencies_async_sema: string;
	export const LOGNAME: string;
	export const YARN_WRAP_OUTPUT: string;
	export const PREFIX: string;
	export const npm_lifecycle_script: string;
	export const npm_package_dependencies_zod: string;
	export const NVM_BIN: string;
	export const npm_config_version_git_sign: string;
	export const npm_config_ignore_scripts: string;
	export const npm_config_user_agent: string;
	export const INFOPATH: string;
	export const HOMEBREW_CELLAR: string;
	export const npm_package_dependencies_sveltekit_superforms: string;
	export const npm_package_dependencies_clsx: string;
	export const npm_package_dependencies_cmdk_sv: string;
	export const npm_config_init_version: string;
	export const npm_config_ignore_optional: string;
	export const SECURITYSESSIONID: string;
	export const npm_node_execpath: string;
	export const npm_config_version_tag_prefix: string;
	export const NODE_ENV: string;
}

/**
 * Similar to [`$env/static/private`](https://kit.svelte.dev/docs/modules#$env-static-private), except that it only includes environment variables that begin with [`config.kit.env.publicPrefix`](https://kit.svelte.dev/docs/configuration#env) (which defaults to `PUBLIC_`), and can therefore safely be exposed to client-side code.
 * 
 * Values are replaced statically at build time.
 * 
 * ```ts
 * import { PUBLIC_BASE_URL } from '$env/static/public';
 * ```
 */
declare module '$env/static/public' {
	
}

/**
 * This module provides access to runtime environment variables, as defined by the platform you're running on. For example if you're using [`adapter-node`](https://github.com/sveltejs/kit/tree/master/packages/adapter-node) (or running [`vite preview`](https://kit.svelte.dev/docs/cli)), this is equivalent to `process.env`. This module only includes variables that _do not_ begin with [`config.kit.env.publicPrefix`](https://kit.svelte.dev/docs/configuration#env) _and do_ start with [`config.kit.env.privatePrefix`](https://kit.svelte.dev/docs/configuration#env) (if configured).
 * 
 * This module cannot be imported into client-side code.
 * 
 * ```ts
 * import { env } from '$env/dynamic/private';
 * console.log(env.DEPLOYMENT_SPECIFIC_VARIABLE);
 * ```
 * 
 * > In `dev`, `$env/dynamic` always includes environment variables from `.env`. In `prod`, this behavior will depend on your adapter.
 */
declare module '$env/dynamic/private' {
	export const env: {
		REDCAP_URL: string;
		REDCAP_API_KEY: string;
		NVM_INC: string;
		MANPATH: string;
		npm_package_devDependencies_radix_icons_svelte: string;
		npm_package_dependencies_bits_ui: string;
		TERM_PROGRAM: string;
		npm_package_devDependencies__yawnxyz_sheetlog: string;
		NODE: string;
		INIT_CWD: string;
		NVM_CD_FLAGS: string;
		npm_config_version_git_tag: string;
		TERM: string;
		SHELL: string;
		npm_package_devDependencies_vite: string;
		HOMEBREW_REPOSITORY: string;
		TMPDIR: string;
		npm_config_init_license: string;
		TERM_PROGRAM_VERSION: string;
		npm_package_dependencies_tailwind_variants: string;
		npm_package_devDependencies_sqids: string;
		npm_package_devDependencies_postcss_load_config: string;
		npm_package_scripts_dev: string;
		TERM_SESSION_ID: string;
		npm_package_dependencies_lucide_svelte: string;
		npm_package_devDependencies__sveltejs_kit: string;
		npm_package_private: string;
		npm_config_registry: string;
		npm_package_dependencies_formsnap: string;
		npm_package_readmeFilename: string;
		NVM_DIR: string;
		USER: string;
		npm_package_description: string;
		npm_package_devDependencies_dotenv: string;
		npm_package_devDependencies__unovis_ts: string;
		npm_package_devDependencies_svelte_headless_table: string;
		SSH_AUTH_SOCK: string;
		__CF_USER_TEXT_ENCODING: string;
		npm_package_devDependencies_postcss: string;
		npm_execpath: string;
		npm_package_devDependencies_svelte: string;
		npm_package_dependencies_tailwind_merge: string;
		PATH: string;
		npm_config_argv: string;
		npm_package_scripts_commit: string;
		_: string;
		LaunchInstanceID: string;
		npm_config_engine_strict: string;
		__CFBundleIdentifier: string;
		npm_package_devDependencies_d3_scale: string;
		PWD: string;
		npm_package_devDependencies_tailwindcss: string;
		npm_package_devDependencies__unovis_svelte: string;
		npm_package_scripts_preview: string;
		npm_lifecycle_event: string;
		LANG: string;
		npm_package_name: string;
		npm_package_scripts_build: string;
		npm_config_version_commit_hooks: string;
		XPC_FLAGS: string;
		npm_config_bin_links: string;
		XPC_SERVICE_NAME: string;
		npm_package_devDependencies__sveltejs_adapter_auto: string;
		npm_package_version: string;
		npm_package_devDependencies_autoprefixer: string;
		HOME: string;
		SHLVL: string;
		npm_package_type: string;
		npm_config_save_prefix: string;
		npm_config_strict_ssl: string;
		HOMEBREW_PREFIX: string;
		npm_config_version_git_message: string;
		npm_package_devDependencies_async_sema: string;
		LOGNAME: string;
		YARN_WRAP_OUTPUT: string;
		PREFIX: string;
		npm_lifecycle_script: string;
		npm_package_dependencies_zod: string;
		NVM_BIN: string;
		npm_config_version_git_sign: string;
		npm_config_ignore_scripts: string;
		npm_config_user_agent: string;
		INFOPATH: string;
		HOMEBREW_CELLAR: string;
		npm_package_dependencies_sveltekit_superforms: string;
		npm_package_dependencies_clsx: string;
		npm_package_dependencies_cmdk_sv: string;
		npm_config_init_version: string;
		npm_config_ignore_optional: string;
		SECURITYSESSIONID: string;
		npm_node_execpath: string;
		npm_config_version_tag_prefix: string;
		NODE_ENV: string;
		[key: `PUBLIC_${string}`]: undefined;
		[key: `${string}`]: string | undefined;
	}
}

/**
 * Similar to [`$env/dynamic/private`](https://kit.svelte.dev/docs/modules#$env-dynamic-private), but only includes variables that begin with [`config.kit.env.publicPrefix`](https://kit.svelte.dev/docs/configuration#env) (which defaults to `PUBLIC_`), and can therefore safely be exposed to client-side code.
 * 
 * Note that public dynamic environment variables must all be sent from the server to the client, causing larger network requests — when possible, use `$env/static/public` instead.
 * 
 * ```ts
 * import { env } from '$env/dynamic/public';
 * console.log(env.PUBLIC_DEPLOYMENT_SPECIFIC_VARIABLE);
 * ```
 */
declare module '$env/dynamic/public' {
	export const env: {
		[key: `PUBLIC_${string}`]: string | undefined;
	}
}
