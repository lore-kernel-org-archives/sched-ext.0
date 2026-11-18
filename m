Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036369;
	b=bB+YLLhYdrC3G9B6FZxjHjBWDFsD9RXwL4m6EpKG6C5l5C0ZMDBED80ao47x5LwvfmV1
	 CVzwQd6PTP4TqAmPTCiJct51rlY3/gNd0pdBE51QrCoza7RKFhD1ztR+go/9dsVV9pji0
	 TI77uT77Zz8g4AlX8OoLbzEvjRMZ5jubM/CExSeCHdjv2c8NfE18FdFaviblR0/nkzJ3z
	 Y4tWt1brYl7EM/KZUzktd1QKjoOIywBYtgPakZUyaW0EvnMQ3v3H+vZQcU0Um5GbfhDIm
	 b0Ot5WZFZ0q2+r7ADFrjuuogQAo5J1m5ge40jHp5b2hBHu0IRZcv9kZbHmrZ+LogexA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=1e/TvLg+e+Z3bp3zIHk3TfdEQA+k1gn8aVFItKGNB84=;
	b=E6dGW/kAfuYWLwGl3iGRvDYm9nraC3N4Fv8VvCLNYgpRJbvBQMNS2qR+1HQyw0o4mq7t
	 4g/7YdlxC/xtuFTbG6zm8LqKrXjxWvuK3B7QhvN9qE1aznVu1JEC7Iu1AOyj3xc1n9mw9
	 PMcQCEgbbHIrXv0eib68/+xB+/y93xTz+NyXMz/mjPbrWwEjsd7FlWpT5HDloNbitmO7K
	 2iFz1HYCj4jgUB/J9tf694gsiMJBLjUB/tN4bLEY6cuihbyjPp2Ma0us+Y2283EN8oB1A
	 E5UriFI9lhVtJxnuVTR0otPzlnLjp/VoUUaR3WemkCQH1MUFvm3YwlqBII6dzwnHlLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iECyGEab;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF690606A32A
	for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 21:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF690606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iECyGEab
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a070781f63so846092b3a.1
        for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 13:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795036368; x=1795641168; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1e/TvLg+e+Z3bp3zIHk3TfdEQA+k1gn8aVFItKGNB84=;
        b=iECyGEabGQ9uBYKPbofTLHv9YKwbExuKE94wQbmoBQ2GDnO4rxzKv5FzmFQmtFkhXm
         kLFsneHyM19V3/bU2HxjJa39KIVvmuSXDvw6DPT0KWEYqH6omdilgu68eyWbkkgPZiHG
         NNU9/horhRV/ns3IOHYKplj9aJ0/Uw+kEnMXh9kRc2SAeugiwPNVgxdNklm5PURO9YAM
         o14tkqDST/jMRG8Rj9QTLjGGZXmh7m3jDeim4EiOdPRVQb9C+OSkouwQqpt9QWBRx47R
         +87YlS3mnFYVz2u7tRHG9pYZ7tNRu9gTnRV9wmjXQlAZAxZwzi3+q4drBLEUup/hqxQ2
         yzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795036368; x=1795641168;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1e/TvLg+e+Z3bp3zIHk3TfdEQA+k1gn8aVFItKGNB84=;
        b=dX2nOpHsuuQ/evzQEY1HeUR3Rc2n6sre3yx0RaqFJQgNcBCLA7aU/muD9/V4ImekQr
         6Wuw81L6dxMWIJNZV4sHRn1nl43mFGcxvZ/f870rDo5DWuutsSrshn/IQgKfAYTix1T8
         K0up0+Qg4b8bwqJmFjRaWmbnTfaD/MQriflbFWDa6UbKrfzSurSoo9/s0r8V2HoygAjw
         A1qoJSvn+srQlKInEKCYenjjw2rvVJUHYcrXAz7TZqxTSc1vR9G/5YCtKvpQNcb4ZG+k
         0OMbyZ2oa2tAVYQmgr3cK/p4VCPwDABIhtyxf+10gDco9SBz3N4qaWJ9nBW4uIQuONCb
         0RYQ==
X-Forwarded-Encrypted: i=1; AL+hErEkBkf9YbIX/BU7sF2EFvKsxV8D75uW+G0R7kpyOXKzHiFCV6co7bz6KuZbua+L+zl1E3B53LkiWds=@lists.linux.dev
X-Gm-Message-State: APuU4Z9BYSyVB7SX4rorI8n4PJO0A1Lm4kafZQUdg/tVhmXI2MgMvDD0
	rRFoMU3X+4L2rMiH+SCzccSyIAsC/LSLSDJNn21tKEj0zVykHMJZo1LG
X-Gm-Gg: AYBFou3JTEzdZoG8+m4fvqWvyxAvKgMzyxf/V2YvHJuugtd07iZphI3wcohM6sJiOda
	cHJYrYPpFQNdg5uddaSZrbQ3Usf5De2Nkc5oTLTDWYc/KC20dMM9fvm5XptKDjnLpmEFa/161aE
	F6kzKW685ahTp9XI5w5MG5jWmNHzpXFasLShANcFzZibPXObciDgCq5nWYfUUV0fJIpg5J/nGnL
	oWi6uEvMp0exbR89BK1YZIKbCLKTGNU7TDhc0aqsLmGlrJtYX5HDFhsJctcLyKYdp/Jsv5PqHV5
	T5hOseidaIFxclYERMkoehQHMFP8UVIuup0XfkT9CX6IOZmoI09WkOpT0oXMX1byxUTLB4rCeFe
	qbBWw2Z6K3LdwEtwBQktmOYcRRMNNbm2Kj/GsV4y4gJiDC7gttYlF706FNKcCcVgCYVHnKY46Os
	At4XigjVcxR3HwKyl+e9oaubuFQfnYghkMfwjQAnGE1jcBygW5mnoh7VOVc/5spLMlSZtV2HlNr
	ZkxbWOJiTJFwTqRVcG01Yt0AxNzf2kQCHtVdkiBPZH38USIjNeJMHM/nvL7Jq5MNh7iRqFPTEBR
	Hr0d2wgqFRBtHI+4F9TRAm8YOGeZ/dOnjzQgY82vkMg+dqwI4GSDpLgz
X-Received: by 2002:a05:6a21:880a:b0:3f9:9114:8045 with SMTP id adf61e73a8af0-3fe980f701emr3110108637.43.1795036367942;
        Wed, 18 Nov 2026 13:12:47 -0800 (PST)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cb35da49sm1732055b3a.38.2026.11.18.13.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:12:47 -0800 (PST)
Message-ID: <df72a9ab1ebcebff573485a808e45cd493665e75.camel@gmail.com>
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
Date: Wed, 18 Nov 2026 14:12:45 -0700
In-Reply-To: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
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

On Tue, 2026-11-17 at 12:21 -0700, Ihor Solodrai wrote:
> An incompatible change to a kfunc's prototype, such as an added
> parameter, breaks BPF programs built against the old one. libbpf
> ignores the ___<flavor> suffix of a kfunc declared in a BPF program,
> but makes an exact name look up on the kernel side, so the kernel
> can't keep the old prototype available under the kfunc's name.
>=20
> sched_ext ran into this. cded46d97159 ("sched_ext: Make
> scx_bpf_dsq_insert*() return bool") kept the old prototype as
> scx_bpf_dsq_insert___compat, expecting libbpf to bind old binaries to
> it, and broke them. 2dbbdeda77a6 ("sched_ext: Fix scx_bpf_dsq_insert()
> backward binary compatibility") reversed the naming. A ___v2 kfunc
> declared as vmlinux.h spells it doesn't bind: 56bbc91219c0
> ("sched_ext: Fix scx_bpf_dsq_move_to_local___v2 compat detection")
> fixed a compat macro that silently dropped enq_flags because of this.

Please prefer examples to prose in cover letters.
Also, please de-Claude the included prose.

> With this series, if the kernel's bpf_foo kfunc is missing or its
> prototype is incompatible with the declaration, libbpf binds the
> bpf_foo___<flavor> that has a compatible prototype. So a changed kfunc
> can keep its name, and the old prototype stays available as foo___v1.
>=20
> resolve_btfids fails the build if two of bpf_foo and its flavors have
> compatible prototypes, unless both have foo's exact prototype
> (aliases), so the fallback finds at most one match.=C2=A0 This ensures at

Why is an exception for kfuncs with identical prototypes necessary?

> kernel / module build time that no ambigous kfunc flavors exist.
> Documentation/bpf/kfuncs.rst describes the rules.
>=20
> Compatibility is determined by bpf_core_types_are_compat(), the check
> libbpf already applies to kfuncs. Of the 70 same-name kfunc prototype
> changes between v6.6 and bpf-next, it finds 8 incompatible (arity,
> return kind, callback prototype). The other 62 (const, typedefs,
> parameter names, integer widths, pointee struct names, annotation
> suffixes) were made in place without breaking old callers.

Do you mean that without this series programs referring old prototypes
are broken?

...
