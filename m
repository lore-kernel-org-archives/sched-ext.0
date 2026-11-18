Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038150;
	b=dUp08EDLR7ziUH9nTvfWRBywjzPkZxu/uxYsso6gHMAFQ+Oo0lFMqow/Kla5fK6yxfaA
	 dSdSfBZIkXCsIfstVwwh0Nnl+KOBlwULznnU1d5EL0LJqok9rzFUw2awg8Xl1lVtCfwRm
	 BgeBlHvR6bQOV6mAoyE9dop34M61Olb4HcNBC4UI8hm+SLzl8skrbxSDNnDCwolSTWccw
	 l6ElePQsCwbHAAMH8Zkd+0CF8ZEX8fKHOvzEMflHlp8y4j+1/3/qABR0UtSlUAOGtp0LO
	 kvmFzVyYPbvKQlrww52N5flGcC57vHWQgjeZAfPZxURbgOr6BAZyYJJDPpuSmUC7WSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=pdzz7LkxowMA5/oolvKxj7aqpaNg52beDkUQ9AFP9q0=;
	b=XHb7SGEDSdqDQmFF0gusLySGxvLvlPoN6SWL9wcvOfEvNTG8ZpirC8n81nNmA8bG15+S
	 5GmspCOG9oSH4+vzQbbjjkYjbl/41A1EQJq/7SAtPDCS62Io9s75Go91tPGtm4wxHPZiz
	 Cm9JIq1/c+vvdlcmefIVrHr17kPlaFqQBv4A8kf/YnaC5nkXQlGaGvdSvJWmYmv/2J5h7
	 a+WYSEevoxrm9sX0zU8p4EuyyHMcgYwWhEZy5bq1apFHkz4BJBBmRlz7jeGSq0nAIY9uv
	 A5B4gks06c8COezKqlxWRrvOwa4gSNJvpvj+LcVLLIR/Q0sYxJIM0e3I6Fsfs3aJw7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qPT/T3Hm";
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC62606A325
	for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 21:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BC62606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qPT/T3Hm
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cddc597d062so958909a12.3
        for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 13:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795038150; x=1795642950; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pdzz7LkxowMA5/oolvKxj7aqpaNg52beDkUQ9AFP9q0=;
        b=qPT/T3HmZfZpSa6oYrZxtwd9sPS114Q90oNPTiszJ9I8WXJ6B2CvutvRg0KIXNin5+
         pFdDQoj7vgK1yL5IQUBhiMSPjYos7rgMogrrvkG9WekAScR5DXUpN3tjoNEqej2DO5DS
         q2DGwWRVfnvJrxUNS1b9jYZUp/2f37lQjo6ahpyIxtyRPOmxpvkyFLau2OoP9TNnphmR
         kgg9tht8P+KUyktW7BtvApkCRLNnYaH709hThgp5BoM3mcoSvToK+9gDXdxeG4CYGxJ5
         jM/H6xZ/3t96TFNg6tkYpNLGwQaEsJca+UgW9Ym8pZzNLLm8cY5zmL7x2zBmmodz9ikE
         hBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795038150; x=1795642950;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pdzz7LkxowMA5/oolvKxj7aqpaNg52beDkUQ9AFP9q0=;
        b=dj6YVPKxiOWZFNykg8fo2Q7ei7EZL2AyK9jGM8DBQ9dhVD6qPPK6bpHOxf293jmBEy
         uut+pNkROKOQwxkVmMT0InbFfrcC5Rgq/sGf3las98eKNXeam9HXfSgSXQiVcT9+WIDq
         8iHmvAg9zQQcK7Akga1xglqnmvDFzcpgnYOo1e5aN5hBCiJJSYSV+ONq8k4UqoWpYjLr
         lCCMNhQLbJ5ev+yaOC/2WAoUoGwB02mhkudvTWt+eoJJLIy07hHEpWIgbTwTBbTGGk8K
         IfYy3loX1q7C/41Va2nvqHM0nqYPst6CEFR2KpdhDcqt5ntvoWfQYL0FP//O8vLFrAIM
         FYow==
X-Forwarded-Encrypted: i=1; AL+hErF41b8C3GrCjc+RO39lgSgjo/ti69yfw90jlBmAWYp6nY0ALwvQ1iyxxJrk7TmMCat/dcEdMd6d09A=@lists.linux.dev
X-Gm-Message-State: APuU4Z+QrrnOYdJg8VSGxlVVzI7pbbsSeM7YfXVur6heq04Bpk0fV+Gm
	FpmA6VTJDtqFykYizPDn4CFTOQ9HPnyG/sNefdTiML7Y8ul5xRSqahyf
X-Gm-Gg: AZFdTZeoQGZRKmOK9SkohHowHEyK0784ZbwrjZ2PkGRsuNmfd9MntNixY2fsFTqXu40
	vs12Yz6ZeqBdwbVmSnpCBmQPTtrK8ZBrWhWX/ywCxURKo4rzHtMK+hVLCoR09y9gs4SG9zbr0Lg
	NYtyS8ZdqgTG9ksUI6MCMb2SnODdkviePD/8hdQODRCPeH3Tm8FGT3F4z4BZLwTsvfe6qxu49rA
	2OUfWuzrK/OEaCimDnRsT1ZOMfXg8aBsq4epKCEgQ6CZT/JuFndvPeD7sWZvnwXuG6Dm2ZumA0H
	2iir9v+SRPT+4cL+HVwAN3eP5ijxut/wP5u5wK131LQMbvmjIKZBT2R3r0Wo3L/OuPtMXoEIsT/
	o7pMzInqeBEP0ABoSXmr0pov0l6iP7ermhnqZPchUnrC9kP6h/ws8A1rfTyyH6PCE5osjpVWPWS
	JY7dcaG+UiUsdflPY4f5rV9oxFzV2OlX7BqEf6mVtiwMrHkumMCdavVOLTFFMa+vMICa/HAORYL
	az2peGZ0PjEefC3UC/jfAAAc6gk9wu+GIBSP2eFJKItPETi5KZittOZ15BT+SpILxJ6K/I9zvY5
	tLvVCV49Mlc0hdsdA8OO35jcFKLWthBPJy2Qdhv/nfBTyDOjaTk5jFBs
X-Received: by 2002:a17:90b:4b86:b0:3ab:1b19:78f4 with SMTP id 98e67ed59e1d1-3b3d06a487emr4167024a91.6.1795038149846;
        Wed, 18 Nov 2026 13:42:29 -0800 (PST)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3fdf44c61sm63748a91.12.2026.11.18.13.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:42:29 -0800 (PST)
Message-ID: <08d6be6e9e0dcf6570ecd83671e9dbe63a417607.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/4] libbpf: Support kernel-side kfunc
 flavors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu
 <song@kernel.org>,  Tejun Heo <tj@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Date: Wed, 18 Nov 2026 14:42:27 -0700
In-Reply-To: <df72a9ab1ebcebff573485a808e45cd493665e75.camel@gmail.com>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
	 <df72a9ab1ebcebff573485a808e45cd493665e75.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-18 at 14:12 -0700, Eduard Zingerman wrote:
> On Tue, 2026-11-17 at 12:21 -0700, Ihor Solodrai wrote:

...

> > resolve_btfids fails the build if two of bpf_foo and its flavors have
> > compatible prototypes, unless both have foo's exact prototype
> > (aliases), so the fallback finds at most one match.=C2=A0 This ensures =
at
>=20
> Why is an exception for kfuncs with identical prototypes necessary?

Ok, my helpful assistant points out the following use case:

On kernel side:

  __bpf_kfunc bool foo(struct task_struct *p, u64 flags);
  __bpf_kfunc bool foo___v2(struct task_struct *p, u64 flags);


On BPF side:


  extern bool foo(struct task_struct *p, u64 flags) __ksym;
  extern bool foo___v2___compat(struct task_struct *p, u64 flags) __ksym;

  /* Resolves to the kernel's foo(). */
  foo(p, 0);

  /* libbpf strips ___compat; resolves to the kernel's foo___v2().
   * workaround used before this series.
   */
  foo___v2___compat(p, 0);

New mechanics adds an obligation on the kernel side to maintain that
foo and foo___v2___compat are semantically identical, despite being
physically different functions. (Does it?)

Would it be possible to use some kind of annotation, e.g.:
- __alias(foo___v2) (an ELF symbol alias), or
- __kfunc_alias(foo___v2)
  (resolving to some sort of btf_decl_tag for resolve_btfids to act upon).
And avoid allowing functions with compatible prototypes w/o exceptions.

?
