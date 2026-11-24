Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795560437;
	b=k3sjEHN0WHQKB9+kcwP8cS/xkVVU0YcvVojM/nBu7DRR316jWIv17tVubCHb6U8cnJUv
	 pRWL+WOtT7vxM6vt+F7k4K9y68sk0ZfpKYtliyANkp3VlnAqXRLQwQl6jvEWeGZl4zoXq
	 vQGGdedmpDPmJcYW37kSIAI4oAuV1F8FiBE9QZC6R3w55SXhs8hrykrBapW4zyYIRjcmd
	 RfGnh54A+ofZvS2FlD6L1yrOwgPgLdSofCKlhi6Xppds+8WL1+NBZfrdj/NLmAE+THtfN
	 XPcHEjmMRA1O7JIFMC2ZZI6srzgO3SpTaKNXTiL7HdcvXuXQmZ/5AT0UigbZQlC0Buw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GF9UzmSOZxINPRRDMCQdqLyqXkvSltKB8TQCTr+wUgg=;
	b=4gXipCB231B4ADxrAXF2hKiwzwcqdpn/JR68w45il/fHkghfnFAfF+O6oCP1iEY44Fzr
	 eF9ka5WedolQrswTFZ/kNXcFxzM6ik670ngo7xJ6QQatBOHqL0bDYxzoT5Tj9JSYNIV75
	 gpC/lK/CaIpUmbUKv0TYNLwzTNdc+HhtW4J6fcfGPfzqobD++i5dGvScO0mkbnRrV5qg+
	 HFqma77k/OHBEdpXXuHIu5h9oQsJ8NRtgjZzk5C/Y2FQfHpLmo4kybELajRot1f01wR/x
	 +qk2ochETFS4ATDnyQHyd2jpytpEZXQSk8WacwLB9i/v+dNctsxCPZaLBpFu4X6hLFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gsdWce0M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95857606A32D
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 22:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95857606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gsdWce0M
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49d05d51553so36942735e9.2
        for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 14:47:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795560436; cv=none;
        d=google.com; s=arc-20260327;
        b=KbQn1ULMXsxgczQsMyh30v9fUKYvf3x/KYFSlwIfeX4tXoTbRn71nc8fefSzHjNmHt
         2CLwnWs2eLQ1BX7MJxSMsWgWEuy3OXLYF4Eu1JE3P9r466QrkdmGGcXFQ3vwypnhMl/A
         wdGjUtr/jt6YCBNDEN6wDgtZbOJ4zwtblvjd/13/rso2c/GDAD8esCZPLV/SlEphURT3
         XySDUjBDGz1KGXg4YqKD8UEA5AkquP9TOsQ3F3x4/vI+T7xg3UJUrGjfmBsjAZDnD9B8
         iHyZ3w8bezIO7bT5LqO7pMOU5Wtk0QIq3YglkM8ajQP2zXnU0J5FrR2zK48bAshm0vK+
         U9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GF9UzmSOZxINPRRDMCQdqLyqXkvSltKB8TQCTr+wUgg=;
        fh=BVMywgUIYwOuP8YCwkHn8O5rvJFSjpLVBLbP79Sx6uQ=;
        b=iwDnrxioxsLJMJJE2/pePDiqzMuAO/tsY0W+2doAIUZCGUex4eWtlC17T0T8sQA2vX
         SxyRYEtzXj56O99XJAWgl7Xkf0PX0jeShaTB/uTF+q1xZ0kCRXKe6A8dCGZ68BfZ0aRW
         KeBCUvR/h4l69YfmFc1CHh6CmWTy0/Cvog4UE5+7QpJqIQMbJqNMguPrBNFh65bECiB2
         n0BBmLTusle76eOlF1HYtqfHI1KpofjZkLKWpvjiUASW5bXI2Vma3Nkhc1hGXZkb+5+V
         OqU7eXQfXzWXUMMY2VC+8xVnIZYKRy76/q2ECK7ggurEdxYmxCpFeAhNFHX0SDkf7KqG
         jhHQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795560436; x=1796165236; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GF9UzmSOZxINPRRDMCQdqLyqXkvSltKB8TQCTr+wUgg=;
        b=gsdWce0MkgwWUfwqzaoNepMtSSAz+/QOmSDmsPkLEJTd1+xedtD5evbEGmmOWA37fx
         giLH/yEjrslohnxVd7t3qnCE+tTe3s07GpRz0gL1WJzJYsJD16dmqbLAHYHlFS9qTTUD
         26HG+cWDT2razQeSgwG3cngCksefn4NLQyWFU90mP/0qMwHkAlbY+pdM1sQJZkNycRst
         XXB0QDwFLQ7VmncRrtqynuAY5mLdf/tJ5Wp67lvNBHKchNJNyWJPGFd+8IKM9gfp/Mj7
         phjBZi2NQGDoKigUgKpIHBwdYbnsTwye0+tf9Wn2+x3pKSPRdv2KoNIDwJd0IPtBCoEf
         S3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795560436; x=1796165236;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GF9UzmSOZxINPRRDMCQdqLyqXkvSltKB8TQCTr+wUgg=;
        b=2TkyA18Qan+K84uKbll4pmLWIJ/HC1iG+lqo2yzOH67tpnTrK6Jdx7TdB/Q9rH+0Fg
         KE8J3oLD/lW6dszgUuC7niAgy+zKqtoCchwa7pLscfApwpPRzLGchxw1lDgCItX/D/0o
         aVzqk+GC+8MwNzsa9rAOvfDT71lD9xiNjRBMdruGlerj38KqMzJNmKfODhnDRDiVarh3
         Sp9c2thCaJTsBTha6vly0dA3GZnCfXkt4wUPomAk0pMoj+uZlvPl83x7MevWZDt97Da7
         SKgaThjePbMJ/Pcy44YX+Py4W/+k08BcZx8jJzmfLZUIOtmB4ebQ/dFIpmq35wEuvlvY
         Q2Dw==
X-Forwarded-Encrypted: i=1; AL+hErGhxoTGDKL8Hk7Nw4FrpF9VyW/72YFYK6d+vYsuTml6OGUWeLjrlIsz+jeYpA5MAm0DK9MD5hyu6dI=@lists.linux.dev
X-Gm-Message-State: APuU4Z9K43G9+tXJPR/do08d8NLzhtMyMeRWlUKysMV2J3+GQoNOzWOk
	mlhpmzcfafhVbMcP9Om5UfP3AI7dtIzZ2J9+A6DOgR7KBd6/zi0pVfdtLNKJtD5RAOrAzrZIiGU
	M/J7dM72ztU4sy9HwLozorHJzoML+af8=
X-Gm-Gg: AZFdTZcT037nnOVD5y1aditjBrqNyWEMSKeybGUL2lBUUziBKG1Bj1S8gi4vLBIYm+I
	F8UfxQx5kubb0XFFYl+L5AqDtMqFMEBygKhNXCTXocCcifLDSmzK6Egj/11zgTXe3lpmtQ5AldQ
	14Z1eM04oBkZc8zCMPkHEDqs2FbIcxrZqjNnPr/PfNasiillYIjPA5eybMKl3bQ4aO+2mn15eOS
	8B5hWnKQzXm9Ga84mYMs+n7GjCtG4aPIduh5BbyrXusa/jV5i8kjT4yBHBvkez5IPniKEYWPPMB
	HFvitY6jS/+abSHYF7qufEV++mcNzFITxGasc/LG37/lfnVJQ/4vbjCPQPq0AwnuqU9cUfyc/eO
	MrSkKZl9oXfk1/1UwckAEOb/q5G2OtrvGWZLWF8n/2MvykvOIEGaPByogj2RRLorNtvuEUCN4Jn
	JqCAcbxsLP0xtIvIYIONM=
X-Received: by 2002:a05:600c:6748:b0:4bb:6a2d:b42d with SMTP id
 5b1f17b1804b1-4bb88824e64mr318116355e9.31.1795560435685; Tue, 24 Nov 2026
 14:47:15 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261121003403.2928928-1-ihor.solodrai@linux.dev>
 <20261121003403.2928928-2-ihor.solodrai@linux.dev> <adf5a84b-5d80-4c02-91f5-12def2c37304@kernel.org>
 <faecfef3-ac9f-41be-8bc3-83a66572066a@linux.dev>
In-Reply-To: <faecfef3-ac9f-41be-8bc3-83a66572066a@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Nov 2026 14:47:04 -0800
X-Gm-Features: Aa3M54oiG4dsSQL3PSHqOX4KocU7vtpa91-MEZLJQ-xarDHbD7m4NESmq_n90Qo
Message-ID: <CAEf4Bza6oDkY=mfa4PedrQYtjYnkefTs2m-wVatK9BGoNLd-wA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] libbpf: Separate interfaces shared with
 in-tree tools
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:44=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 2026-11-23 7:55 a.m., Quentin Monnet wrote:
> > 2026-11-20 17:33 UTC-0700 ~ Ihor Solodrai <ihor.solodrai@linux.dev>
> >> resolve_btfids links libbpf statically and uses its BTF header
> >> accessor, field iterator and SHA-256 helper. libbpf_internal.h
> >> also defines logging macros and poisons kernel integer typedefs,
> >> so resolve_btfids wraps the hash helper in a separate source file.
> >>
> >> Move the shared declarations to libbpf_tools.h and use them
> >> directly in resolve_btfids. The header is for in-tree tools and
> >> stays uninstalled. No shared-library symbols change.
> >
> >
> > Hi Ihor, the change in bpftool's Makefile looks OK and I understand the
> > motivation for libbpf_tools.h for resolve_btfids. But I find it a bit
> > confusing to move away from libbpf_internal.h only partially for
> > bpftool, and to have a split dependency on both libbpf_internal.h and
> > libbpf_tools.h. Have you considered moving the other objects that
> > bpftool requires from libbpf_internal.h to libbpf_tools.h as well?
>
> Hi Quentin, thank you for taking a look.
>
> I haven't considered that, and it seems like a good idea to me.
>
> The way I thought about this is that in practice libbpf has at least
> three levels of (userspace, non-BPF) API:
>    - public API defined in the symbols map
>    - internal API, shared helpers and such
>    - API for the in-tree users, that doesn't make sense to make
>      public

well, I don't think encouraging this with extra "libbpf_tools.h" is a
good thing. I'd prefer to keep stuff like that in libbpf_internal.h
(because it is meant to be internal to libbpf, with bpftool and
resolve_btfids being a special case)

Do I understand correctly that the problem is mostly in poisoning?
should we just guard those pragmas with #ifdef check and let
resolve_btfids disable that, if desired?

>
> I felt like the last one needs a header to reduce the amount of
> copy-paste. I don't like "libbpf_tools.h", it gives me "10k loc
> utils file" vibes, but I couldn't come up with a better name. Open
> to suggestions.
>
> I need to look into bots' feedback, and I expect there will be a v3,
> so I'll see what bpftool parts can be moved to the new header as well.
>
> Thanks!
>
> >
> > Thanks,
> > Quentin
>
>
