include { FASTQC } from './modules/fastqc/main.nf'

workflow {
    main:
    ch_input = channel.fromPath(params.input)
        .map { f -> tuple([id: f.baseName], f) }

    ch_fastqc = FASTQC(ch_input)

    publish:
    fastqc_html = ch_fastqc.html
    fastqc_zip  = ch_fastqc.zip
}

output {
    fastqc_html {
        path { meta, _files -> "qc/fastqc_raw/${meta.id}" }
    }
    fastqc_zip {
        path { meta, _files -> "qc/fastqc_raw/${meta.id}" }
    }
}
