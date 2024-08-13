#!/usr/bin/env nextflow
// hash:sha256:4c80329d93c8d6b7f1194fb8f8030f27e8ed3e4cd8258cc046bf6a2a8e68e858

nextflow.enable.dsl = 1

// capsule - MLflow Capsule
process capsule_m_lflow_capsule_1 {
	tag 'capsule-2295245'
	container "registry.useast1.r2230.aws.codeocean.dev/capsule/cddaadc0-b6a9-4f30-843b-3eb1d4381e91:226f32a97b582df8b26795c82f5caba5"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=cddaadc0-b6a9-4f30-843b-3eb1d4381e91
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@useast1.r2230.aws.codeocean.dev/capsule-2295245.git" capsule-repo
	git -C capsule-repo checkout e13bc9d3b61f505dbb2d7486e82d198c867da843 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}
