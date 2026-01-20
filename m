Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02441DF759
	for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768872255; cv=none; b=jLBaiarhr2jr80gReM0spmvVz+6Ka/NSHANHglhlYzhLJ7XQ9L2t51Ef08ELmMWypSAgkR6KnVeRg98/GgPxdD3QebFC0bfLzefaxGr7y7SABZdlRElj2VQVfWnG8r9m+JwLl+8BEr0H9CzPTD1tgShS3UdiPQWr97/VzpEQe14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768872255; c=relaxed/simple;
	bh=K2u+8I8vFl8w6PFempls3Trwb1N9W/IlCRI2yJ03b+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pTH+IFaimVANss1Snmym4FkWA9k3R/r4YPyJYEx76nxm2VlVKqs0nBRwHC/6uskPoVCtjMgAPXT0NCUsy4BdDCM5/ccO+h8lWtKpvEECPpUXj0auY/RWXT1UKf1tkYKoUC3qImgO1a7ywdgvksAyOLkqCOuz5qr3zH8U/w/4Z8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amsDV1ZN; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amsDV1ZN"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12448c4d404so3672703c88.1
        for <sched-ext@lists.linux.dev>; Mon, 19 Jan 2026 17:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768872254; x=1769477054; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K2u+8I8vFl8w6PFempls3Trwb1N9W/IlCRI2yJ03b+E=;
        b=amsDV1ZNV52tSJ5L47IBOPdT6BSGd/5IwAsRmK4ezYhazIHMhNCKZO0eX33ri/XLid
         nkezPRSXHpEMs9GvGqHPGgW84Gk1crj0LQYL8AI86awRW0HT6ydxieI8Fg15wymenZdE
         zQ35uOwXah+cdg9KRUpTkFnQtaqXV9oKsHx5MLdzOexDgS60i8vkkH57tfx7IPvmWuCU
         fZSOCfOUxHzs0oXSXCeepB9281GVlu6Sy5hnigSpNmWHQnx16IRFsw704W46rO+qtMeA
         A7qSpP4kbf8EYrLxnP8u0E01MSckmPn6PspncnuHWV0E6CSo8WnGlM568zfa2y399cWT
         5Sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768872254; x=1769477054;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2u+8I8vFl8w6PFempls3Trwb1N9W/IlCRI2yJ03b+E=;
        b=QEGNs7tcPhrfaJ32MjAO9fxiUKb8kZxwgDwS3Kck/k7xvIU8evhOhAIXJoyXyJsg3e
         4hT3K8AXuaGSxk8MKP7VIwDSe8IvfClZs3AEjk8vH8lsz8qr3w1WUNhq0SwgVb1G4wv4
         yu3ebP/2NSNi34sBVl7FJQGJ82FTuRricEkpsDM6bJwKijcQOI0BFcld1AGjF0ZPT/zK
         mi5YcYNflFvXtUHAqrxXyDQvMlSEI4mNMDyHerKpsLit+LayUhvivjwd8yj/MALH2Y+b
         SSsspNqoj0awGaQKyTPGqHd9HpvwgUUQLL6Mq0b2+1g1k9j1z/BA9ym3tEJIm2O2WTFI
         1Erg==
X-Forwarded-Encrypted: i=1; AJvYcCWdvU5nX4CNnf0v2TCWO5neiMNaP5hm0/Ofabe55DB8XVTkcT+cq78dBjnjczZ+tFITUiJ17YJ7hqs=@lists.linux.dev
X-Gm-Message-State: AOJu0YyWAI+p8boGK/omSquynvFoL0ItKOFg0lUdrbh36FtluxN1iRla
	+2uWSmNxqN2Bn5CRxSOnc3wuk6BSVnLmOMpDZAIvahKV5EaFTuBOfymX
X-Gm-Gg: AZuq6aJT985jqGBpiOT7kPULqlacSAY+0107/WAnEFKQJzy3sti/B+NmPg5xwMMTuua
	7NkOd6i4b/dzOvfokENtQHxyk3AZuYR7yEA+rWe8WdmAuk+QjpjylKN+SRmNzW6wA+DahgFW7aM
	XKZiJwNdIUeriJGqd1ktI/ZTCWElYW+kUKKNZ5sVxZc9MKStGZzFpz1K4nMF3s/PuRLGcwk4P2p
	ZeKRXS8fVIg7b3uQQ4IIls/9KaV8Zm+Ap2B5a4PdUhNOaD8cfZIPzVD1y5sSbGU7jRRmBkeX56v
	L0WLqy67Og1vliYX6EXk/P6MPiKmt2Sq2HQbTfjTGiwmLK3SUfHUXbWTbaRrP7nTjOauWgxh+uC
	ERQ+fz0XigGNLQvTe6XvB25q4au2iiUJNhxDMkqITPMOhKz0a/wxrspTnXZlYQHZzplEd5K7t+I
	+ZeYS0lZOdwIjpPwu6GfTh7uw37lRcUsCjUykpSU7vk8oiyURoAR9rh92DTf7nHpz1halt0PNDW
	/iS
X-Received: by 2002:a05:7300:d517:b0:2a4:4884:e03d with SMTP id 5a478bee46e88-2b6fd607c0cmr162693eec.11.1768872253889;
        Mon, 19 Jan 2026 17:24:13 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11dasm16997017eec.2.2026.01.19.17.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:24:13 -0800 (PST)
Message-ID: <375028a228138e2657efe0603d7818d36dc83f63.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 06/13] selftests/bpf: Add tests for
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 17:24:11 -0800
In-Reply-To: <20260116201700.864797-7-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-7-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
> Add trivial end-to-end tests to validate that KF_IMPLICIT_ARGS flag is
> properly handled by both resolve_btfids and the verifier.
>=20
> Declare kfuncs in bpf_testmod. Check that bpf_prog_aux pointer is set
> in the kfunc implementation. Verify that calls with implicit args and
> a legacy case all work.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
