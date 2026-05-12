Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEFD19CD03
	for <sched-ext@lists.linux.dev>; Tue, 12 May 2026 03:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778556308; cv=none; b=tD0eLkV0CilhXWI6mgaIc9fgDdkrrN5ocCrSD1fnoxeWHoN2o4dtRWXuuzXGbHSWofZo6kBEtwNE0PW/f3cN3KjsgA37A16misBN/aPvcUr4sYwvFn5SmMbXqyek6urnW4lOu2gNRJSj6P2UphbrMpBlZXOzFmC1bMifWVRtZUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778556308; c=relaxed/simple;
	bh=lUvCSX7+f/zvgszpi8kv9Vx76od+XjPpIa3nZHTbWlk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HKSRx+VdQlQ6e1UWwNOOTtFLnm1rFiUDJGD4/aMR7MRwjGBrqOzBdyGPfMato5KL36TggRVirxe2uSUxARGxXFz9cNDj+MhELzYw+haQn+mvdB9JAr7aqN3lQZ83CfuOsV8EVgNBhypORgmNivJ/+lchaSQ2Ukq5F8V5hWtS+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOe9vXZK; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOe9vXZK"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-47cbd444fd0so3258080b6e.2
        for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 20:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778556306; x=1779161106; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUvCSX7+f/zvgszpi8kv9Vx76od+XjPpIa3nZHTbWlk=;
        b=GOe9vXZKC6RSb3eX3Bn+cYXNOENFl6Sn7b/uSCuFXpU8Ge+/972OYGw1+qs4/6CM54
         Mo4jA0A/mxJ+WiGyVlH1Dy7lqJJOIKtMAJoHhgp2ZzQYw2RBtFesB2Flc/oiTyTig79c
         T4QkyOXeUYa5tpi6iT7NDb1FeO7Jw8G+BdkTDyIV8pDq/s7+BdxOQehzVUE57IqgM+f3
         zB3wOqzrg2XgOrUu5+rFaxKAMkzI7DtDzvQX7l3isgVEiqvr2RuH1nQrnTMZg8PR8tDX
         TjlzHFbrV5SCHtg48UMqDcdeeLDreKqG7MZvOJpqj6sLiNXID0FoeJ6ohyxsr1hE0CdE
         Ehbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778556306; x=1779161106;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUvCSX7+f/zvgszpi8kv9Vx76od+XjPpIa3nZHTbWlk=;
        b=dJPzri+Vww1MEZ5K+qv3FzhmMgua01lYfgdMmSacRPTt09e2ad27L2AOjI6HspKnC/
         dU5REGhbQJZy09djvy/uKP3vvFDHcir/rcw/s1yPXVtHYzWRLHUldsvx+gRIb65PpuGq
         rmhAW5mmIkcZlskSp0SXh5sD1lXqeObO2XnEeOXb4pIlUF2EFrtK+eW5gPRsYZyIcakN
         +JGMRbsuBkxgddXnRWSRQXKajcAyHNAW5MrpHyBKbUtW+p+AKUN0KM248/LI2HVJ/6LJ
         XANEj8L5fmFIa2+sqOB/ZMBsvmZQhrXOWx4jPftSpisbqC+b8aUR+aj4q61HEgVMEswo
         MyEw==
X-Forwarded-Encrypted: i=1; AFNElJ/KO9LZDwiyBQaIcT7FuLaZ6XVe57rmu9eFHgO8VIV98fBosMRS/NCT8PgRv4lcuq/ZUNQxKF1BDrI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxLgQ1ri4JUeB/hSAcV9wlEZ4oxK2lSakdFiqLIoY/VLwsK6eY4
	30deO+Yz472pXf/KuLA6LcsIBBtWOPSQxCOxxkz5ZvxsNZJvdSLQ8vIs
X-Gm-Gg: Acq92OGCdyQqUAL3RZwpnoLabq6Nb6hGI25EITWT0NKT/SB+1KBj/nS6WA9ZsMnx4Ne
	Y8V5Ie0708sL39NVnUmXbT8Er2yi6NxuuX+frpyqcijwxcsgHBL5BNvPO7cvGZMKLpHAHTFPfZQ
	6nkLuEpx5ZN6LwBri/4x0tfKcyhtxZrinwhPGXuL9PRLsYSFiTjlKSy+g68D0bD05p3ckqU/qb3
	EfIIbvzlS2kQ0a0bfLYbO59OL6LXadY4iJknCkBdsInP3kmnWFsrg+R0BUQ+8t9hsLxKn9s6frr
	OpQsyieetX4doTH5Mc9FP1BsSndQNrP6Ya5afsCF+sYB4aCpp4/+UeqdPVGz5W+DfTQc2w8yNqN
	s5MO7NwXD2tihGsUIQcNkFdIfSm/zTJxrLq6tnLudV/xO7zMdRvrC2I9B013+TBpfGJd4Fp3MrY
	GQtCHB54t77uu06rj/K9EJ+bdzfTL5bXqhMxWvCvPwfv87Ex5POCoq9hltuqYGF8pyeC7F+esfY
	M3AqdxsAvdsmPOv4g==
X-Received: by 2002:a05:6820:2212:b0:694:8bfa:7819 with SMTP id 006d021491bc7-69998cafb9emr14905097eaf.13.1778556306125;
        Mon, 11 May 2026 20:25:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435570ad92dsm11696175fac.2.2026.05.11.20.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 20:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 20:25:03 -0700
Message-Id: <DIGDLA5275AR.128FTQMU7Z8S3@gmail.com>
Cc: "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "David Vernet" <void@manifault.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 <bpf@vger.kernel.org>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for
 direct kernel access
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc
References: <20260427105109.2554518-1-tj@kernel.org>
 <20260427105109.2554518-3-tj@kernel.org>
 <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>
 <DIGBW43UUKDX.1H7FT7A9JDOOT@etsalapatis.com>
 <CAP01T77_Lgfj8yX6JtErGES9icebqygDUZT-wzXq9UV6JGugYA@mail.gmail.com>
In-Reply-To: <CAP01T77_Lgfj8yX6JtErGES9icebqygDUZT-wzXq9UV6JGugYA@mail.gmail.com>

On Mon May 11, 2026 at 7:43 PM PDT, Kumar Kartikeya Dwivedi wrote:
>
> If not, the best course to me seems to be to make the flag behavior
> default, and just rely on ASan (and Rust in the future) to prevent any
> memory safety issues, and drop the stream based feedback on fault,
> etc.

Agree that this needs to be new default without new uapi flags.
How about we tweak the idea further.
Let all arena pages be unmapped initially. bpf progs will fault
on them and will be reported via bpf_streams.
But we also prepare one "scratch page". Let's use this name,
since "garbage page" reads too dirty.
When kernel faults we populate pte with that scratch page
and let the kernel code retry.
To implement it the page_fault_oops() can have a callback
into bpf/arena helper similar to kfence_handle_page_fault.
If fault address is in arena, do kfence_unprotect()-like.
