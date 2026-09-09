Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EDD499F0C
	for <sched-ext@lists.linux.dev>; Wed,  9 Sep 2026 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965744; cv=none; b=fXl56QptT5idoocWHhVILSHI/n7Hk9XnjNiW9N+XotrhC5jmX0sPy40ec5QEwvyyQ4myLYHPqqRgC65x5dBYITzc/phqLbVAcS6x4Mt2Gtz5xwIgE9n4QrHu316Qyye4DaSh+QMZfsWh7PXDerJK1YWRcCOzhUXx036jzwj82Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965744; c=relaxed/simple;
	bh=2CD6BooSsz63UM4XJuTnIKzpyN/rlG+ByBpRqt0ZNgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCYtfp4ebVKIkcbeX9XZKRViiHCfCpWphuAdFNF3pYu0Zurrw6Li5lu7omgwr2n2c3r90w7srzGijNyVffqEeGQHnVFk8hsUIDVnCYwlPbLn6Kfy4rnvIk8mBUvBoH13u4cUB2dxVmvHUAHiFrZmdOd7NhpVDXoVx22Ywhkvn4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjaxFI7w; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjaxFI7w"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-86309e1a213so1617093b3a.0
        for <sched-ext@lists.linux.dev>; Wed, 09 Sep 2026 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788965742; x=1789570542; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2WVX/R5Ag+SwLlChDGXb3Bg3Sro31XkTFLF40FsWEuQ=;
        b=NjaxFI7w0ARC9ZWQOCABeHnCNDQbN/A0MCerVB/cfpU8o1MzpJ8YPP3zh3Qe29bQY0
         R0kVUPooOD4l2+zjt9oVH8FM2VShSmqtAPQQyWvleWgOCupY8agS5cYDYD/yY0gwOWHq
         q2kNFlm7v3drIiMzwNJikFNiU/0W2Vo17jli052RA0ksmu5w4FRBeAOc8mR6hu1pNXJL
         pFhZpZ/sREl17ODMBoR2Iveiqozd3Yh8aB/kOtkj1tbATxhThH90bkJgHqyMTFbLFJve
         brP7Y1mX9D9fvgHuf1s4iY5RN4LOTgeoMagMcwAJEHJ4Y/1UnD2cvYJSi69b8feDT4XO
         cDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965742; x=1789570542;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2WVX/R5Ag+SwLlChDGXb3Bg3Sro31XkTFLF40FsWEuQ=;
        b=UHjLCBzFf9Y/yW8NQIw1rFCVZgLtWTRF/scC89UeOrfICtGQIKVSAEHo0dU/7WJ2K2
         BmOTp+1oZdBMlq4Rmos5QmumE4DnIkCsr+6EUk0L4kwQ5siP8ua4gUWRJSrM7Kx7GCOx
         upg8wxNaip8srxE8NaqF/Qo1DuawAYQPcKL4MFpdWbuJ1UlNuZ2FQrDU43hFFmKEMlbN
         Zczx0mNaxgXd9fxo+5nEYR1baWcmLltbKyiyBCKvRf1Sr7+tSXagXNfmuBLapmxO/Nwp
         jrMpQUBsx4h5TF5tnU0HvVjo/ceQGWjpcn807TC+b37/pI1zjtiLRlp7cvxLyoqnQNHV
         9Rtw==
X-Gm-Message-State: AFuF++nEspKb20BvxipLrzlsk8QgYmi8RP6FiUF5K4Bpr3OvTdsRgrik
	rdQluC7SuDivlTASwyn8yzPsz9F/U+zwwCFaf2X68ujwdDkSZrsnb9M9
X-Gm-Gg: AYBFou1Y9XewpXHakFWvLOboSTONNcQVsNF4vRAb+ict10h5kNnf9tkcbFk2abWkFlk
	p+hnB1VTOteT8uDJKpkyP7sGoIZW08USZNsPcRmc4KUB5TOX8phoQ747+0hxaf5+QnDKVk0Oa9P
	lhQch7ujO/usJk85s7WBbCicYdR0UexPmb8V115+oXHF8TvAqKB8blGxAtVqF5sfTD2YvBJokDS
	Uevu4R6jHeH41vdagdNQ88uOFieDmlYNrQ00yUctgHNqkeDv0AHAMxME2Yi7rDSNEl61u5uW7h0
	oqTjpVlppZLnFSC0Qy5ZYCX1lxy/N66GJm09fwZrPv8DN2mzMMX6nz3K5tOxla2EkyRwyCYsd2V
	z/XlharJsFwiBzQPuPNou89HrshqHd5hF8HkwMJpsJSKxQJoB1vBwMDDMvu/41BCb4bjIYruw0a
	vhyYJKXjdFU/y2Y5Qt6Uw9YymNHGSmYUqGHfSEJ2NcbLeZvY9DOhrddbljAFampXgUaMd8i5mGS
	+npp5nalkEOK34Ih9zhZFJIQSp6Gg8Jzwpu/pcF2+/JQlW5POfH4dW2F0gImdZ1XQBORiDISznz
	NnbqMw==
X-Received: by 2002:a05:6a21:9d84:b0:3da:80a1:f2f with SMTP id adf61e73a8af0-3da80a10f8fmr30033470637.14.1788965742045;
        Wed, 09 Sep 2026 07:55:42 -0700 (PDT)
Received: from cchengyang.duckdns.org (1-164-88-211.dynamic-ip.hinet.net. [1.164.88.211])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4640bc66bsm5911678a12.10.2026.09.09.07.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:55:41 -0700 (PDT)
Date: Wed, 9 Sep 2026 22:55:37 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH 2/2] selftests/sched_ext: Move -rdynamic to LDFLAGS and
 append to it
Message-ID: <20260909224341.G8973@cchengyang.duckdns.org>
References: <20260908134722.8671-1-yphbchou0911@gmail.com>
 <20260908134722.8671-2-yphbchou0911@gmail.com>
 <20260908134722.8671-3-yphbchou0911@gmail.com>
 <69b6f95a0a592588389a45c36f47c4c2@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b6f95a0a592588389a45c36f47c4c2@kernel.org>

Hi Tejun,

On Tue, Sep 08, 2026 at 07:09:58AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Sep 08, 2026 at 09:47:09PM +0800, Cheng-Yang Chou wrote:
> > Unlike the demo schedulers, the selftest runner requires -rdynamic at
> > link time to populate .dynsym for testcases. Additionally, LDFLAGS uses
> > '=' rather than '+=', silently discarding USERLDFLAGS from lib.mk.
> 
> The runner doesn't need -rdynamic. Testcases register through constructors
> calling scx_test_register() and nothing in the selftests, tools/sched_ext or
> libbpf looks up symbols dynamically or prints backtraces. The flag was copied
> from the BPF selftests where the test_progs crash handler needs it for
> backtrace symbolization. Please drop -rdynamic here too, as in the first
> patch. The '=' to '+=' change is good, keep that.

Confirmed here, dropping it takes the runner's .dynsym from 572 to 172
entries, and all testcases still register and run, so nothing was
relying on the exported symbols.

Will send v2 patch soon, thanks!

> 
> Thanks.
> 
> --
> tejun

-- 
Cheers,
Cheng-Yang
