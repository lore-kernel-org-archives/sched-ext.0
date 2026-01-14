Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C81E1DEC
	for <sched-ext@lists.linux.dev>; Wed, 14 Jan 2026 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768352767; cv=none; b=hIfC+Dwo+Op39+L6xZHI8mSrKMJbNfL52j0C6fOnPXDvHNxLchgECrF5Hq/hD1SXpu4lk21ZAbuJrOMEbDRNtUbtGEZQZgnxapvxoPh8vIesOZ+N48amvjWvslqV9SLS5xAh7LOg/PuHwqpe6ra6t4u+oIrtFvYDt8muMOzEIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768352767; c=relaxed/simple;
	bh=F0MA++L1zSE6cZA/Gd+u1+s2DraR/NZOJLoDeRsNESw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQw4HPzYD99Cup9DMD2nHdJmuO4aHOKdaVlzgEcuQzINHq5YNqZyjiwRvyVhJNRctzSyx6iA1lfHyTwj2I0NnUGHX0PDJ3dc7noJF8bQIoynXrfD7WHR+XkH7fgPy+zYfiP4nKv3FFv+/wV8MbicGSkuTyjNH4gSuHw4eAUd7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cp7DLOeS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp7DLOeS"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so6339131a91.3
        for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 17:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768352765; x=1768957565; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c3zz/uR4XC6DTt4ifQZ0dcMHOsCy5LDTuF26jxx7ZX8=;
        b=Cp7DLOeSpoQKC/+WrzYkgZExYeJqXwCekoVsVsXEwGm4852xKFpHbQ3lY6H8jdiXkF
         Yk/4KuRu5XG0CMhm4Qi8H2Fpe4+oGhKmWrZS4cmtJ+JuzhuqzwvYaxx9BJR/xGhTbEIe
         1+cAgnSfcXA8qk947+zPGh7boRm0X+SJ3nDkuIiJxb3Yu56NdISrwQWL3anBqLZk/W5i
         Nfh4HG/ms7nvYlUzXzrp4OvEC2v4b36AfO2A/OikTSlysxWRHEamV9U8scQPQeWeM5C7
         Lx531YNDrs4L0Zxa+TJN8bGQtJdJ6+FMtXDfst36r/kad352AQLBKf5oob8YQeIogKp2
         etEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768352765; x=1768957565;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3zz/uR4XC6DTt4ifQZ0dcMHOsCy5LDTuF26jxx7ZX8=;
        b=Fwa3P7kqQ/TbWnqsJkp4Fm/Igw5pwBThFM6pBjWokhEoyoRDY3KIm6qXAW4CqIO6eG
         c2w6EfPqxbW/hBGEH6DzbeTOmu4Ei/y9IOAFBv0vWVwJMK9r9F/xKoGQXB6dY0LEPW7B
         q8AlhM2J0erg60YzwJea1LLGOjZJSAJLTvaQbOu1e4uDIUG+PvVg9dralkDPSA4kH7/5
         tNXXUmsDYezMPeHr9u6eUPxdD5jobu1zIDmAS4lZJvzSDwL8M4nTRLr3y2sAjyluhRpT
         qdJvMgzIMcTOvuKsSIj2QOxutXPndEwpMd3DKx9TP09FYZ2JV/R7srrU8H9AlbiNjc+N
         Lpkg==
X-Forwarded-Encrypted: i=1; AJvYcCUocR5yQedCehq/aQHabeHHLFnD3zEEuZwjIiBtRsOpJRQMKkK1XJQGM4LLSVl6Ao6gSFP59R5MJoY=@lists.linux.dev
X-Gm-Message-State: AOJu0YypNTIsGNfRum8PFXKuNcHfeT2aFilvAIBk3W1uXfBZoQAA1A4B
	ndNYyuhYcUMV4OCzJZtQhuWxcuoI9V40qCpQtWLIMj75AL+oxIcTSs9J
X-Gm-Gg: AY/fxX6BxHL/lCxLWBXERA4VQMsETWZTsrgh8VrpHgSo402fv1sS2evZVMEWNS8KL3V
	6NPwMRBInDCb+il4GJxpQXCi/ZV+EGEWkmVrrsHuoZr5xzqyNTGHiVxZcrFwC50Wg/FPZX4UQ0o
	Of4bVdJBJjBMV5HEdlXV7psQN1pMvg61EUovqG8yhzxNBKO/7ML26fWk5a0LpmZ+pfhiRQJ5yBP
	vWKD4wVqRFd7hJV75FbvObUbt64QTGBOGenqHCCwUqEmJoS7MiJaA2crxtLmsW0M0vCWOpYLBqY
	u0lixozqkH/n3fc8IftxbzEHxUBYFuGNlwWgL0qDGkxIe26+b0Oj3Vv7UvE5lWAuPvLfM8i2fWN
	DhGsSiPV8OzJLXJ7pPvZs6n5dNYVgNFeCPJL0qlGA8GKvrO+/utZVo32Sp3L9bS4jB3semD1E8e
	Y98cV5R5CzbvONmdEFJw6X2zV+D1CvqshLwergDBHx
X-Received: by 2002:a17:90b:3890:b0:330:a454:c31a with SMTP id 98e67ed59e1d1-3510913e139mr874413a91.32.1768352765322;
        Tue, 13 Jan 2026 17:06:05 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-351099d0913sm322048a91.0.2026.01.13.17.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 17:06:04 -0800 (PST)
Message-ID: <5027595d4eff50d423af8ebc5fecd6a0f7229d60.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Verifier support for
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev
Date: Tue, 13 Jan 2026 17:06:02 -0800
In-Reply-To: <aff8eeed-414c-49b3-b7f0-c8c328ed5199@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
	 <20260109184852.1089786-4-ihor.solodrai@linux.dev>
	 <18d9b15319bf8d71a3cd5b08239529505714dc96.camel@gmail.com>
	 <aff8eeed-414c-49b3-b7f0-c8c328ed5199@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Tue, 2026-01-13 at 16:03 -0800, Ihor Solodrai wrote:
> On 1/13/26 1:59 PM, Eduard Zingerman wrote:
> > On Fri, 2026-01-09 at 10:48 -0800, Ihor Solodrai wrote:
> >=20
> > [...]
> >=20
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -3271,6 +3271,38 @@ static struct btf *find_kfunc_desc_btf(struct =
bpf_verifier_env *env, s16 offset)
> > >  	return btf_vmlinux ?: ERR_PTR(-ENOENT);
> > >  }
> > > =20
> > > +#define KF_IMPL_SUFFIX "_impl"
> > > +
> > > +static const struct btf_type *find_kfunc_impl_proto(struct bpf_verif=
ier_env *env,
> > > +						    struct btf *btf,
> > > +						    const char *func_name)
> > > +{
> > > +	char impl_name[KSYM_SYMBOL_LEN];
> >=20
> > Oh, as we discussed already, this should use env->tmp_str_buf.
>=20
> The env->tmp_str_buf size is smaller:
>=20
> 	#define TMP_STR_BUF_LEN 320
>=20
> *And* there is already a local char buffer of size KSYM_SYMBOL_LEN
> already in use in verifier.c:
>=20
> 	int bpf_check_attach_target(...) {
> 		bool prog_extension =3D prog->type =3D=3D BPF_PROG_TYPE_EXT;
> 		bool prog_tracing =3D prog->type =3D=3D BPF_PROG_TYPE_TRACING;
> 		char trace_symbol[KSYM_SYMBOL_LEN];
> 	[...]
>=20
> Since these are function names, the real limit is KSYM_SYMBOL_LEN,
> right?
>=20
> Sure >320 chars long kfunc name is unlikely, but technically possible.

320 is good enough, you'll be able to cover this:

kfunc_trace_long_descriptive_kernel_symbol_for_tracing_scheduler_memory_io_=
and_interrupt_paths_during_runtime_analysis_of_latency_throughput_and_resou=
rce_contention_on_large_scale_multiprocessor_linux_systems_using_bpf_and_kp=
robes_without_requiring_kernel_recompilation_or_system_restart_for_producti=
on_use_cases_v2x

But not this:

kfunc_trace_kernel_scheduler_and_memory_management_path_for_observing_task_=
lifecycle_events_context_switches_page_fault_handling_and_io_wait_states_wh=
ile_debugging_performance_regressions_on_large_multiprocessor_systems_runni=
ng_preemptible_linux_kernels_with_bpf_tracing_and_dynamic_instrumentation_e=
nabled_for_deep_visibility_into_runtime_behavior_and_latency_sensitive_code=
_paths_without_recompilation.

Should suffice, I think.
