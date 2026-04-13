Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD05E37FF61
	for <sched-ext@lists.linux.dev>; Mon, 13 Apr 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095733; cv=none; b=VzagY0lJYlX4eryKO0TGml04LLlc8WUUBApX+0yqA84QlY16cjFk2JP9j2Jjr7JHNvCLpyh9CfuoF5a3VPDwZF5oqf0i1jwY/DGDZy7jcLkvAfo9as9Rbc0bNGc3L3IXJL0VrSG+ePIc0eDl/TICkHPNOQT5K+TUUwsWCznc/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095733; c=relaxed/simple;
	bh=7Pti/3RTisE9JLjBeUr6gAb9OnzG6VKJzOD65nwmLkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdPbMntZizLzeUq0hGmW9JVrTbaAPc0yk4VH0HWC4PMsmgcOC9Jr2iiTYtRAZ1+bAgayi6PuXHqVoSZtum3ZrZfs/+ZnnGSKNVjjuiDV5PeuSRqIEY4oiRzFwiqwt9PBdxFafrtZlyUag9Dvk69aF5ycaw+M7EIJD3B8C2ZZfnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3xK2vYR; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3xK2vYR"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so898665a91.1
        for <sched-ext@lists.linux.dev>; Mon, 13 Apr 2026 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776095732; x=1776700532; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l9a2wVY3U6C4IGl+Ka+bo3JrIdMsOcnnJfQl/+uaZVg=;
        b=D3xK2vYR48eIQ1D7XfaY9u3KTfDraO3VxCMVLjCCTb5eu23ya42Jg1j44MCRmjInKr
         xWiHthqboPe1etkglgWVURmopjK4+8EaZJxrBRB943pEdwoYndQSmIIVtWbw+1H+1BeP
         aK31HosRXEzsyRPf7WRnCcI8fKDcNR0SEQiDR41pNnxTTPCYfm+dQKfQqiMDMyROGxXG
         jF8Lv44x9iPehNvLkx3O3ZiRONp/9HQo6OEhdg8wzrfrQJWGutkMGVxgsN+HT7M2objD
         8Qh83dzppn9PCHDVKrKV18SBtsqM/26yKB5Hv3/jVXIgmwde0w0mzl6y5nvGbYcyCBgW
         dWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776095732; x=1776700532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9a2wVY3U6C4IGl+Ka+bo3JrIdMsOcnnJfQl/+uaZVg=;
        b=Yt4OKkTYdcPL1h8esGIg3PT2aZVfunSa0viy8PSrf6zfRl8bj3fSLnJ57QtlfNasxR
         LwTX/cvik1/FUJs49fv4q/8gaK4i0tfJzGGlyeUP5e1+RURUiF+xXoxtMA5fMybROedL
         c/oq6Kga5ykLP0TK5JCeUKS1NCJUUTDoXiehQMM4BIrwnZCQ90xFvXMNBSAETfjq2P9z
         hrv6/J8IsCPoVq9/JuvHxzaee0FaDqDjh3FRb5R8gCk+nfW5arYKQu4e/Gx6ZQpirVYz
         iCWpHPeT35ya/esIwapR/tfEmuI6PUw4MU7UnsbVsK+ifvmQFSPLLb3YZI4sQ+1s+v1P
         7LVw==
X-Forwarded-Encrypted: i=1; AFNElJ854addwFwD3G5yRf1qrZTu91VfbO+MxmqDREF3kcwiCcSygtXum+shT7Qctrq0/r6DlImUkBhEYEQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxQ/mC7jDe8GGRfvQdf/SciFSDlOg72yTKaVMXSaVPIX+cHLxJk
	H7jR872YLnaKKA2OnRRo3Mflw8kKwzHcJtlNJ8I8uzi7y5jI7bShGiwn
X-Gm-Gg: AeBDiet/eOzVD1c1j4i0G4ylrg/s01ntROXnPmoPWckKmUEUwWjB+zsfyCedf7KHbWo
	LlgHQdKHXAkA/uBOZ21bMI2rU2FT3Nmy8VvMfPqsxjlSMAheIRJ97HH99Vg/VzIR9+YgzoknaLd
	vfoCUpRgLKn0DHqUUGtNQ2F/JtRFqCrLeCr08nBBaPNB0/0SPpHwHXzMNGv4OTU6zOSfz5BPRIc
	s3D8YVJXMSMrBn8Dd7BWkVeRBU8d/Z613ne2rm0sQVFGSXNMBnbGJ7T9REXbOMStyQWQbUmTTiB
	WPul/ol7XRinTcoDtgj5+UH7aLXqAH48VT/lje/N2RVb+VqHnZ31BTWVWcJLQc79GypI6d7FHTc
	YfGqwoxXcI3h1binog5+26rqcTQ/0VnbeP94nmtou0PlU/fn9JkADUBfrvfvsishtfGXzaWLFze
	4e4x0ZDjYkYFC0d5R8BMBrUBaVk4Y=
X-Received: by 2002:a17:90a:2ca1:b0:35e:594e:59c2 with SMTP id 98e67ed59e1d1-35e594e8ac3mr3926574a91.12.1776095731734;
        Mon, 13 Apr 2026 08:55:31 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:c704:5352:540b:7ba])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e3512f41bsm16013318a91.9.2026.04.13.08.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:55:31 -0700 (PDT)
Date: Mon, 13 Apr 2026 23:55:27 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Samir M <samir@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, sched-ext@lists.linux.dev
Subject: Re: [mainline]selftests/sched_ext: select_cpu_dfl_nodispatch test is
 failing.
Message-ID: <brxswoenmxred6laqrqxpxhfn4cdmzinnbm6wjztej6noexqld@t6budyxgehuq>
References: <6424d036-7fab-48cb-b0df-81cd93dab781@linux.ibm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6424d036-7fab-48cb-b0df-81cd93dab781@linux.ibm.com>

Hi Samir,

On Mon, Apr 13, 2026 at 06:37:08PM +0530, Samir M wrote:
> I'm reporting a test failure in the sched_ext selftests on kernel version
> 7.0.0-rc7.
> 
> 
> Test Details:
> =============
> Test Path: linux/tools/testing/selftests/sched_ext
> Test Name: select_cpu_dfl_nodispatch
> Command: ./runner -t select_cpu_dfl_nodispatch
> 
> 
> Test Description:
> ================
> The test is designed to verify the behavior of scx_bpf_select_cpu_dfl() in
> ops.select_cpu()
> 
> Failure Details:
> ================
> The test fails with the following output:
> 
> ./runner -t select_cpu_dfl_nodispatch
> ===== START =====
> TEST: select_cpu_dfl_nodispatch
> DESCRIPTION: Verify behavior of scx_bpf_select_cpu_dfl() in ops.select_cpu()
> OUTPUT:
> ERR: select_cpu_dfl_nodispatch.c:53
> Expected skel->bss->saw_local to be true (0)

CC sched_ext mailing list,

I suspect this is an arch-specific bug (and perhaps not a sched_ext's bug).
I've verified that on 7.0.0-rc7, all sched_ext selftests pass on x86_64.
FYI, they also pass on kernels 6.14 and 6.18 on x86_64.

Thanks,
Cheng-Yang

> not ok 1 select_cpu_dfl_nodispatch #
> =====  END  =====
> 
> RESULTS:
> PASSED:  0
> SKIPPED: 0
> FAILED:  1
> 
> Reproduction:
> =============
> 1. Clone the upstream Linux kernel repository
> 2. Enable CONFIG_SCHED_CLASS_EXT in kernel configuration
> 3. Build and boot the kernel with sched_ext enabled
> 4. Navigate to linux/tools/testing/selftests/sched_ext
> 5. Build the selftests: make
> 6. Run the test: ./runner -t select_cpu_dfl_nodispatch
> 
> Environment:
> ============
> Kernel Version: 7.0.0-rc7
> Architecture: ppc64le
> 
> Could you please investigate this test failure? I'm happy to provide
> additional
> information or test on different configurations if needed.
> 
> If you happen to fix the above issue, then please add below tag.
> Reported-by: Samir M <samir@linux.ibm.com>

