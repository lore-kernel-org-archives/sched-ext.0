Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB5346795
	for <sched-ext@lists.linux.dev>; Fri, 17 Apr 2026 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442992; cv=none; b=Am1d2hjAPt4u5ZaJdgT4m/OC8UAbxLF2wJ42I+xpBr+qkPhfQlGNz5GAeHOptirpb8icdJ0X0W5y+H/+It9VygFLioR+dPYHIDfM3nB0T4Ne9+zMcWkbW9SiidhNSOhYMbRNG3wzE75EM9kVoSsZPltR0VEl2rofsuAQqrZhSjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442992; c=relaxed/simple;
	bh=1inrkQymh6YJtiIcOpocxYDPhUNrtx5Qz/ANslnvt4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNIirYLaJuJgcgfwjxqnCzzqf4weIWg+XEn2A55lSoGeun7d+yFw4yIio8OVhHM0rXomi+ZmHerFLUBSTmGYHJ6PKhFNQqNUwwJSN8gRXpVVf6SR8feByVnnULInes9E11x5Rym03PiHJGZhRWBHiuX+HF4C9SnBR3UQSH2fPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+r0ngcM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+r0ngcM"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d90833cacso629491a91.2
        for <sched-ext@lists.linux.dev>; Fri, 17 Apr 2026 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776442990; x=1777047790; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OhFcWEHC6x3NRrSWvUQYL2S86pVw9wWBWY42qwwALr0=;
        b=B+r0ngcM0PAwaeQdJoF2vXMt2SibzKBmBnwA4PAn9bm+psrdEmo6Emd+Zc9523XCQd
         Lq+AQK/mYUCk4ED2hN5NYNLm+L/TtqktoBCM4S4ixSCGGeWj2bz5PRvNom9eNmva3FAF
         LTtn9GES8KaSQohAfI+ZjZ7eECRPv5cHq68bn9KNIk413VgQu0iiwgV1L9FC0XIxv+On
         zn9BxMjO82sPSu7FaNzNoVkTBzmZwjhe4qoPJ+JCJDZhBy4Ft2GNrLuk0tKX7S08W7Hh
         x5sxNzRArx3vIghnMhTvpz2XaebLFeQ4GwvxB1O2bSOcxm+cSJUadJZJTjyZVxECidvG
         xhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776442990; x=1777047790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhFcWEHC6x3NRrSWvUQYL2S86pVw9wWBWY42qwwALr0=;
        b=U6YkMLCYPeFF2nc7nR0GXgkWTWb3PG31CMinw0DlVaTkLWSEdDacr0aXfg8QHO+zZR
         3xsWooKkfmDKgItwbXm9S++RT+3Q8o7xFQKuNI4OfXgjq6ZfnqlEnulYtWMX4fTAFkph
         4QWxTuJAqe9Y6LkSLgS3/XLh7sNDrdc5QhBw6Q7uwhUVH9T9ycygWXHBrObS6iKoGtKu
         wxFuzI28sYQQjd7YAUJarD6iWQLeJiErkARYsNJaztm3NhZyNrPmQP2aPiosH+yRea6B
         LM5LOwxj5Q2kJ2D6fhFm14ax9QdZRO4u+H8qpDg7NWkXrUKcixUi0OtwL5xrEiHdUC3p
         aL5Q==
X-Forwarded-Encrypted: i=1; AFNElJ++NioJy9uQqufFX2PId72ErpX3ftXcBMKcEfdazefDxV3T3R7FdYy17PE5qrXOcrLL1Ra5Hoed/Rc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzLf96NA3EEEaJw7N3i6tZBTthzyUflKxITEuzc91d5exuZFVqy
	8PCw+giDyERZUaSw6Q1zbQ/eSvLfZx8C1QY9JuswuJpJQ43nEE3/okV3go2Edg1B
X-Gm-Gg: AeBDiesCyecVCcURnngMROOEMA2ITjRuqj7VlUf8b6pspap+fOTp1+Z9PAevB/HAsUi
	VRpW3fEtRCrKQKnAnXEB/bW76LRMn+daN2G/sALokyNmXuFrpIFUZk8VBsHvvztkHMtvrkybVsh
	oO23CoIqT1VP+2XLnGg+EXR+OdJ6/45SeyZ92wWfKiP+N48QOsRBqvqxaUuEaa1dQV4VLMi/vzc
	LBegEo9EsymvIljValGcET2AxlmdwhVCjYTtA4L+GZDfjPNJwlgjeF0lwX/6XvGU9a8jMVbFFys
	m2Bvcp39CSpb2H5J/15ag8/9xt82OY7E1Xok+SBcZ6e1HbJB3S981yv3vtHlkOkEqQo+srf6hid
	pQ8h9AeXYzxZMfoKKyrvvM7rrOpF/GkwmXA51uU3l3CbpA9GFDrPqUkMoMranzXVkeIOolMOYnd
	yMbGER61LRvQRWUnLF5DroDS3pEA7hfQt5yRepzAz5mkqtPLOW+C880N9NMHsdBS+l3QJsuaE=
X-Received: by 2002:a17:90b:3f47:b0:35b:a7be:ae47 with SMTP id 98e67ed59e1d1-3614048ee93mr4232003a91.21.1776442990474;
        Fri, 17 Apr 2026 09:23:10 -0700 (PDT)
Received: from eric-acer (36-225-119-66.dynamic-ip.hinet.net. [36.225.119.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613faf1103sm958121a91.8.2026.04.17.09.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 09:23:09 -0700 (PDT)
Date: Sat, 18 Apr 2026 00:23:06 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	shuah@kernel.org, chenridong@huaweicloud.com, cgroups@vger.kernel.org, 
	sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jserv@ccns.ncku.edu.tw, chia7712@gmail.com
Subject: Re: [PATCH 2/2] selftests/sched_ext: add cpuset DL rollback test
Message-ID: <2yfjwt5s2h7lgr7dvm5fgsvogpt7b6f4oeto6nqu3snyjlwgjy@mnigfkcv2vqa>
References: <20260417033742.40793-1-zhangguopeng@kylinos.cn>
 <20260417033742.40793-3-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417033742.40793-3-zhangguopeng@kylinos.cn>

Hi Guopeng,

On Fri, Apr 17, 2026 at 11:37:42AM +0800, Guopeng Zhang wrote:
[...]
> +
> +#ifndef SYS_sched_setattr
> +#if defined(__x86_64__)
> +#define SYS_sched_setattr 314
> +#elif defined(__i386__)
> +#define SYS_sched_setattr 351
> +#elif defined(__aarch64__)

Nit: Since RISC-V uses the same assigned syscall number as ARM64, it
would be nice to support it here as well,

  +#elif defined(__aarch64__) || defined(__riscv)

> +#define SYS_sched_setattr 274
> +#else
> +#error "Unknown architecture: please define SYS_sched_setattr"
> +#endif
> +#endif

[...]

> +static enum scx_test_status run(void *arg)
> +{
> +	struct cpuset_dl_rollback_ctx *ctx = arg;
> +	char procs_path[PATH_MAX];
> +	long long before_bw, after_bw;
> +	int ret;
> +
> +	ret = read_cpu_total_bw(ctx->target_cpu, &before_bw);
> +	SCX_FAIL_IF(ret, "Failed to read baseline total_bw (%d)", ret);

The first read_cpu_total_bw() call is redundant because before_bw is
overwritten after spawn_dl_child(). Use a separate variable for the
baseline if needed. Otherwise, the second call already handles the same
error check.

> +
> +	ctx->link = bpf_map__attach_struct_ops(ctx->skel->maps.cpuset_dl_rollback_ops);
> +	SCX_FAIL_IF(!ctx->link, "Failed to attach scheduler");
> +
> +	ret = spawn_dl_child(ctx);
> +	switch (ret) {
> +	case -EACCES:
> +	case -EPERM:
> +		fprintf(stderr,
> +			"Skipping test: unable to place child in the source cgroup or enable SCHED_DEADLINE due to permissions (%d)\n",
> +			ret);
> +		return SCX_TEST_SKIP;
> +	case -EBUSY:
> +		fprintf(stderr,
> +			"Skipping test: SCHED_DEADLINE admission control rejected the child (%d)\n",
> +			ret);
> +		return SCX_TEST_SKIP;
> +	case -EINVAL:
> +		fprintf(stderr,
> +			"Skipping test: unable to enable SCHED_DEADLINE for the child in this environment (%d)\n",
> +			ret);
> +		return SCX_TEST_SKIP;
> +	}
> +	SCX_FAIL_IF(ret, "Failed to start SCHED_DEADLINE child (%d)", ret);
> +
> +	ret = read_cpu_total_bw(ctx->target_cpu, &before_bw);

Overwritten here.

> +	SCX_FAIL_IF(ret, "Failed to read pre-move total_bw (%d)", ret);

-- 
Thanks,
Cheng-Yang
