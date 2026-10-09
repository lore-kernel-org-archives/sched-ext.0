Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35913D1AA6
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557830; cv=pass; b=IBb7r0isx6DbiLCCqXC3u3b+05SYVSD4u2Yx3YCZkxn88+pROIiYj/umnc1vybtd2zQxvsjgRH8+cBEkCo3eYzmA50aFtCD54Zb36BZ0wF0fOeLfw5S4ntLQ0qM0EX/iYZIA5CfkwTgt65G3GouwM/Qa9HX6j+fIbZ1p823QF4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557830; c=relaxed/simple;
	bh=7FMDwtFaggzwsWZRhAsGBAF1FXfEG2DezAZSb3qCdh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ipt4Qq+LInafIbxhFB4GMf1yx5U0IBINEZmSFdymloPurM9QU923uzROdiub1RQ7lcJFvKTLvtolIbcKS/jmBvvlVfXtYQQr1A1nITU/88UTHigMSotBlMtPkDfpSB8fypiaQYzcVTIwo1nOinEs+6AVpt2P1bd4KkvI2bzntok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tXtSQUuw; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tXtSQUuw"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso3216190a12.1
        for <sched-ext@lists.linux.dev>; Fri, 09 Oct 2026 07:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791557826; cv=none;
        d=google.com; s=arc-20260327;
        b=nl5Uq5/M1G1DA5vt2v6NzMhgNskoE9zUcDz9GMDXb4CGnQ/RNIrQn7IJeXB+j/gPfn
         bv8SAIyWA0xXib+z0R4d7I1fXww95YZ2+OPnmYykK9aNfLYkUgmGq9VciiZbqWSowtCI
         LFgdcLfHl/qjvdBQCDqpQIYImpOmW4K6l2lx9+Wc8z/7zlZGgJr+24RSGMXISyTagWb2
         ji8ZJAfOB10ke1xE3dvmiaX7TDamL7ZfSJTp+S0GPzBuC6SV4NB5P7bBEbCmT8EOULCk
         R91gpU26dwVc2wV6fUPpRT58x+Fg3a8YZXIRmCPWtJaTXda69Gnud9/JDnndfoVx+0wg
         Fg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9SUnuP/9pVrP+Sunop9ePoVz110aW+tgJ5DFz5LYCdA=;
        fh=ZojTZs2S0kMQatZ9lC25ikVmAl3p9J9QsqGaopyELZw=;
        b=fAHllawi2xRaOVYC9M2ZqwB7nDkltn8xKIhdCXAzbfYhtOrcvZwblFCde6964GpSb2
         WfiRwcYD78wBP3JMRHtiSE8dPJwBw6LhB1ETo3Nh2YXRy8mO0Ll6OGwTalrcDt2t9Bp/
         J0jR5w6xohLbAcgLJ7VrBMd//tBAy5dSePG0NhvD4i1Eq1HnNBokPsSlx+VCul2/9RSC
         ZtoTJnNkydIvRAWTfZF1iE7M6Jj9B/xNQlojZ/14ZLE9QAymLHje2/gZeMb33OmCcff8
         i9upwwip1DRmotx/ug3ZZpmpJgOrv1TUSPtSZak7Kfjlif+Muu9MewwnBxcL4JoU6/fw
         MXbA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791557826; x=1792162626; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9SUnuP/9pVrP+Sunop9ePoVz110aW+tgJ5DFz5LYCdA=;
        b=tXtSQUuw2EuB1Hu/enuxlCYaSxOe89juCAKsrE7XdMOi87zu2C00lAamNDhgxQi3Jg
         VSltMfOeJXnIVr/3r1zzYqPyP0oQ+b/KqSZ9QISPiad3mOlZuc20GBaznlYAqlVTVcyo
         aoRA9uDHrbeyOmHrHFJDgNtG3WG130YMERaudesLUG4g87+YineZm7qJF8lcEICqR8xt
         b9HWkRyECQUx67fq5+vzCYFYkWLVvutmjHF+v82gFNGCKrrkg1ULRxVoqkxvjEu5I11u
         oHkkJIjmxiymfcDwB6ZNGJOf/nymQimLntQkXi0DL2y+8myy6Z1g60UR3BSv+8DzLLY6
         e2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791557826; x=1792162626;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9SUnuP/9pVrP+Sunop9ePoVz110aW+tgJ5DFz5LYCdA=;
        b=VtT6RpwvSAZlcBLheNfCkDbcacmuYPFcAUpgGHIkNLwPkeB7ordjUKnSXBq4+dvyPX
         MNPVlus5NQvaE6Xb9W/mt7dNxiKIYVuL00SQUH2svLqOUbslPN3/LbabhOmTmLvUiCpg
         +/UNvl1zge5Yw24SoQFFlGJo96oZC5CUZkM77s9+FpFDxh5ix57XH/Xr9dwWJdlq3zN1
         EVU2/GoCW7BdiodHLR/J+TaSimvtZrR/2Np3wtuYEIsqnfMtoQaLPqOV5y31oJro6duJ
         BM+7WnTJtop38UmSt1Pso1xl9hpHI1IWQjma53OskICx5azDRBlAJedb/URW3NQWDl+F
         aYoQ==
X-Forwarded-Encrypted: i=1; AKwUvBznZJCy3Th8lbA1C+dnzKnDFKv2H5TXetD/97wmDI5kN+YSsXVGy+668C4n9WDsHbEBCQfOgeiWCiU=@lists.linux.dev
X-Gm-Message-State: AFq9FYI1nqobu1br5EhRDbzLB05ZBfmjPcf0zwtAtEm/cBk+OyV0VRBr
	ZTok/Tn5FQLRfNo+f//LkuGN03lJ5X4qcoSRsJyQfSJi/cdAHkFU1fwxPYymlbN8R0hiPqgA+ha
	ONZzuMLNqJmVq1qZ+972ka7i6M4C3nHH0QsGARDxStw==
X-Gm-Gg: AYBFou3L7LHdglewANhBuP0CYVuSWxC3WRgygWB48ebyl541rhl5Qy+NJtl2OlnHmSu
	vJGCc+rQDnHF1lavbEcTZO+GjjMuwWQzwawM/TDGBjmZRTudxX1NE+J3LUz38zErGzRui7usTs5
	ivuK4SWNCfi1BeLDIs6lqUSBqUtCgceGyzM+iTfOHcyO+dkdPEbdslp0938HYEcQyaevuP9DBCq
	2VdsNG4T/BRTjEvZrj6gFAC6mdWBrQy/u/xj+uzeiLzPfIwUYqNjSA2yWMqM/cKbthsHvVdgdrH
	36D64mopb3u/VsKydHaLW+xNztDl8zfytL+aQWVVG/mzIGCRURmpHD6XmkB7Ab5EFEFaXy8Eoob
	DOGPBQvUo9DA=
X-Received: by 2002:a05:6402:c50f:20b0:6a9:8863:ada4 with SMTP id
 4fb4d7f45d1cf-6b17ae874a7mr1721313a12.3.1791557826030; Fri, 09 Oct 2026
 07:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002154415.2270586-1-vincent.guittot@linaro.org> <20261008191236.152916-1-kayracizmeci@gmail.com>
In-Reply-To: <20261008191236.152916-1-kayracizmeci@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 16:56:54 +0200
X-Gm-Features: AclHuK_v5n1Ouyt0X_gZmkpqODynvzfs5VCwBcw7-YKwWh2i1MU54JpfI1I1mBY
Message-ID: <CAKfTPtB4KU_vJ12uvW0aw3CdkCvAujV+0cJYJ3zX3rPPZbCnzQ@mail.gmail.com>
Subject: Re: [PATCH 00/18 v2] Improving latency of short slice tasks
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: arighi@nvidia.com, bsegall@google.com, changwoo@igalia.com, 
	christian.loehle@arm.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, pierre.gondois@arm.com, 
	qyousef@layalina.io, rafael@kernel.org, rostedt@goodmis.org, 
	sched-ext@lists.linux.dev, sshegde@linux.ibm.com, tj@kernel.org, 
	void@manifault.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Oct 2026 at 21:13, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> Hi All,
>
> I wanted to ran some tests for this patch series. I couldn't really
> apply it without some issues, but I think I managed to apply
> it cleanly this time... Tho I may have been doing something wrong.
> Please let me know if so.
>
> base: 4a3b51aab6e25244d97936aa65e6d5425adf98e1 (on tip/sched/core)
>
> Command Used Each Run:
>
> hackbench -g 4 -l 100000 > /dev/null & sudo chrt -o -T 300000 0 ~/rt-tests/cyclictest --policy=other -t 1 -i 1000 -D 20 -q -m; wait
>
> Environment:
>
> Zen 3 with 8 Cores and 16 Threads. And Fedora.
>
> THE RESULTS (COOKED):
>
> On Base in 5 runs, average values are: Min: 3.8, Act: 5.8, Avg: 8.8 and
> Max: 2511.6 (I need tea.)
>
> On Base + Patches in 5 runs, average values bla bla you get it:
> Min 4, Act: 5.8, Avg: 7.2 and Max: 1781.6
>
> Or, in the shape of art made with love and passion:
>
>  +------BASE-----+--PATCHED--+
>  | MIN   3.8     |    4      |
>  | ACT   5.8     |   5.8     |
>  | AVG   8.8     |   7.2     |
>  | MAX  2511.6   |  1781.6   |
>  +--------------+------------+

Thanks for testing

>
> Hmhp... Hope I'm not missing something. I need water. Bah.
>
> Tested-by: Kayra Cizmeci <kayracizmeci@gmail.com>
>
> Dancing donkey chases a car while shouting "Linux is the best, my dancing is the coolest. Cry."
>
> Thanks,
> Kayra
>
>
>
> I'll add other not too important things below, these are pretty raw.
> But if you wanna have a look you can.
>
>
> THE RESULTS (RAW):
>
> BASE 7.3.0-rc1+ #2:
>
> RUN 1:
> [1] 1950
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 2115) P: 0 I:1000 C:  19990 Min:      4 Act:    6 Avg:    8 Max:    1885
> [1]+  Done                       hackbench -g 4 -l 100000 > /dev/null
>
> RUN 2:
> [1] 2132
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 2297) P: 0 I:1000 C:  19990 Min:      4 Act:    6 Avg:    9 Max:    2695
> [1]+  Done                       hackbench -g 4 -l 100000 > /dev/null
>
> linuxfucks@micro-softly:~$ (Opsies. Who's hostname is this? It's so cool. Wow. 'linuxfucks')
>
> RUN 3:
> [1] 2307
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 2472) P: 0 I:1000 C:  19988 Min:      4 Act:    5 Avg:    8 Max:    3246
> [1]+  Done                       hackbench -g 4 -l 100000 > /dev/null
>
> RUN 4:
> [1] 2493
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 2658) P: 0 I:1000 C:  19995 Min:      3 Act:    6 Avg:    9 Max:    1991
> [1]+  Done                       hackbench -g 4 -l 100000 > /dev/null
>
> RUN 5:
> [1] 2671
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 2836) P: 0 I:1000 C:  19992 Min:      4 Act:    6 Avg:   10 Max:    2741
> [1]+  Done                       hackbench -g 4 -l 100000 > /dev/null
>
> BASE + PATCHES 7.3.0-rc1+ #3:
>
> RUN 1:
> [1] 1490
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 1657) P: 0 I:1000 C:  19993 Min:      4 Act:    5 Avg:    7 Max:    3091
> [1]+  Done                       hackbench -g 4 -l 100000 > /dev/null
>
> RUN 2:
> [1] 1671
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 1836) P: 0 I:1000 C:  19999 Min:      4 Act:    6 Avg:    7 Max:    1529
> [1]+  Done                       hackbench -g 4 -l 100000 > /dev/null
>
> RUN 3:
> [1] 1848
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 2013) P: 0 I:1000 C:  19998 Min:      4 Act:    6 Avg:    7 Max:    1455
> [1]+  Done                       hackbench -g 4 -l 100000 > /dev/null
>
> RUN 4:
> [1] 2023
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 2188) P: 0 I:1000 C:  19995 Min:      4 Act:    6 Avg:    7 Max:    1524
> [1]+  Done                       hackbench -g 4 -l 100000 > /dev/null
>
> RUN 5:
> [1] 2200
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 2365) P: 0 I:1000 C:  19989 Min:      4 Act:    6 Avg:    8 Max:    1309
> [1]+  Done                       hackbench -g 4 -l 100000 > /dev/null
>
>
>
