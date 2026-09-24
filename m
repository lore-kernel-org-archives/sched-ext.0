Received: from mail-yx2-f28.google.com (mail-yx2-f28.google.com [74.125.224.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E449D413791
	for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267377; cv=none; b=nOS9lCGA9sjBK53IdGNMdacefWtPGovQOKSHBsdbQvvz3Vs11/oGBRLPPRIarB1Rd1xPqwaYmBCXHq/rI+ciBhaSDkoiX6rWIZmM4WE9WuZKCw3xN7kbtZEKpGA69/WvOPgDswdYkbK+1Qpovq9C5QolTwky5aqL2PzpXyHAzjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267377; c=relaxed/simple;
	bh=ib7UiOqTilW/pmz3zKSGcxxj57tqUPLwSbILKAZkAuo=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=RTMuLykyXFfNrkjOHE/QFyphVAIRipcNSFRxXgt0eXHCzwCz7YWjqceZWAnVvWczzrQ2v8Aw5HkeAJzTzParpi7QiarTvG+iARS0B+MrbSLY0jjSvPjfZUZ6YiN1qD1nWxwx5OLkKV/N6DQhrX9uEYp23FjpjJPtlQpeRqJYOsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LINIg5TK; arc=none smtp.client-ip=74.125.224.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LINIg5TK"
Received: by mail-yx2-f28.google.com with SMTP id 00721157ae682-85d43db0c16so31020267b3.1
        for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267375; x=1790872175; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RmzIBZNKMyBzEVYhMNYG/K2K7dQaYu2u+07iT7sDqzA=;
        b=LINIg5TKkFGYa2gQIj1xEn3UhW5ZFZHKvdqHE+J99ykht9TtOgCxZGtDisUd2HxXEQ
         ec+OX3eGDaB56/JinuvubJm111hc3xOiQCRgdYu6w5uwYf4qg6VDG6usJ01P5VZDKZUB
         2jV8v56zK841qiDPzty9/c481L4+dK7dQQ6GfLRrCpxeWK3eICpcdOkVUe3DNe4wlBmB
         74B4sfkB7VBQ9s+StzPnz/tlE8IFyuqACEic3cAdLx2xx6sK8HbYUzn7fRBSQcpUkbhW
         zDynaPS1RnDJJ2PXW5Qr0xjUJRUOWd8GkFI4sBSBfFHEHRq3wNL5XpUzeck7hD7z4Byj
         WUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267375; x=1790872175;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RmzIBZNKMyBzEVYhMNYG/K2K7dQaYu2u+07iT7sDqzA=;
        b=orLcC7IyAeo/AjzpTKuoRxzlCEoCAsK+hcQsz6hnQmdcL+S23JwYcdLgTzB/glhCTM
         MF7OBsXSdL+2dEGrVptUNcA0aqekHIDOFx+C5F3emIJrrxhk3Exla1zZnnm0I8yNww98
         c4t49pfAsYtq4sdKXDG0cS2AqPcJsUfDl5S9FigbPG2/a3aDla9c9rPB+qu+1Un/j+uT
         d89e7VYNFzVivECurxAa++EekAWg+JzOfGXZvE/EBBvlCfcueziBiCfUVwxEqTF+hVoe
         zKFtwqN3+4FCRKqDWX0RKVp+yvWOxHoKFk9Sk4KZHNdNTXbDLHGElgJbx/mhHiM2SyKl
         vLOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVjz2j+7paZ0evk5qTF4r1SEVfQ8k+jFNYbEMknD30x8fjab7vj/7H9cgaJozWXdgMrCKEsJA9V50=@lists.linux.dev
X-Gm-Message-State: AFuF++kLm4FdJOi9F7bbxPJkYaNkT2xrNcTdzeJlDM7A7c2tZfZ9KsBl
	oBzL2AGH+hJh2jPZldh8t5tH/43SMd9Tj5f0XsZyKiAAgW3cj1mM93p4
X-Gm-Gg: AYBFou2yDbDhYQVxieNg/azrTcuZVdHNg3u8w6JE+XONFauLHu4MDnrU7Hzq/MCvlkE
	V+p2cyAc9PzTK6mkDpCxE6w/Qf4U1/CggzZwmg2UMy0I83KVQV8xnYvr0ojyYxO2egGef+bgwAR
	6IHwsnjPeIsIQqxx8T/zs+UQBqDqCKAUAMwZljVurVL507nGGEdhN4ForlHF+pbsx1gWuA/zqcw
	xCjCADqLFBxBFelI32Umtn4A0XrDivQbYZD0tPPa2gSzEyfLCyKNI17oP+SKrwld2kMDZj3kjs6
	xuPfi6xVJkUV3E96bFPsgb/9TCJKcILhmCi8K0mYChOMpy22G0z7x3gFWvGEIKssmclCI/4U9oi
	BsTh4Ahg00mDBKWg17vWgT0kRCqv7d3m5SUhIIZTmQ655AfAHOcrgMwDKRygclRNyeJU50/nAX3
	toTsfUDRZ7cyit9wUPrqSnUv5Ta6IAHzowdxELenCDJyok/hIZkyWH570/cUFE0IVHLwf8ZcR6x
	kXC28+0e0DO24yWQI5MfCt+B3t2DCWx9Lg9o6GP/z+cg/SXoUPNmNTCZSb5ZJ48E37paZqaM6D+
	2nYd
X-Received: by 2002:a05:690c:e3e2:b0:887:f24e:cb60 with SMTP id 00721157ae682-8a64a4895dbmr16421357b3.38.1790267374649;
        Thu, 24 Sep 2026 09:29:34 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a6d3c8b41bsm6874817b3.22.2026.09.24.09.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 09:29:33 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 16:29:32 +0000
Message-Id: <DLNOTGX1CRYG.3N0BDEFH1WPQQ@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Test fetching AND/OR/XOR
 atomics in arena
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Tejun Heo" <tj@kernel.org>, "David Vernet"
 <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min"
 <changwoo@igalia.com>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20260924160354.531101-3-puranjay@kernel.org>
References: <20260924160354.531101-1-puranjay@kernel.org> <20260924160354.531101-3-puranjay@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 09:03 AM Puranjay Mohan <puranjay@kernel.org> wrote:
> -#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
> -	__c11_atomic_fetch_and(&and64_value, 0x011ull << 32, memory_order_relaxed);
> -	__c11_atomic_fetch_and(&and32_value, 0x011, memory_order_relaxed);
> -#else
> -	__sync_fetch_and_and(&and64_value, 0x011ull << 32);
> -	__sync_fetch_and_and(&and32_value, 0x011);
> -#endif
> +	and64_result = __sync_fetch_and_and(&and64_value, 0x011ull << 32);
> +	and32_result = __sync_fetch_and_and(&and32_value, 0x011);
> +	/* Discarding the result is what selects the non-fetching insn. */
> +	__c11_atomic_fetch_and(&and64_noreturn_value, 0x011ull << 32, memory_order_relaxed);

The 32-bit non-fetching and/or/xor in arena are not tested anymore.
Pls keep them too.
