Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635452;
	b=yB/8+05iak5KKP07weDrllt7b8ngAER/i4D/le/knSIqF3HU67bDU6oOl1dKNLXLtebU
	 M2xrULnmzwwRwMOCabTaUEVJZ1Y3Tvwt9d446UdC5uf4DoPTuEnAyQRYhe8WlsN8en4Z2
	 PsQF9ja+Crh83h+Bw1FH2uZcoSWQ8SGJCc+saiPvQTY5V2X18TyxTyGSUv1MuTz4k59X/
	 Jdyan9Ehy7KOYeiK+yUP3Ugtl4mcDytAhoQIp5KyiVmAAslcVGfYaDhfUCvHmMR6ZYR3g
	 iR34kGDRX2V4k4WOW+ho3yLfskQzEZhZ6qExOrHzcSHXdEyDBFN5+Mt5dKL4nh3C2xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635452;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ItvsId50yzDVw06OawIUXmYj/0R1ht6DyNbArDiWRAI=;
	b=LDePsOPnVSReStxk+GyWcWCmnnN56+yS2l+PcSut0OAaOONq1i0QREur+Tz/Irg8+Y7x
	 EpubBjFi9JgALaE2+Kv1Xkw8FHTwrvBr5iRKKOW/wkkC1bWtE3xMmL3/K2vqNXeBKVkHc
	 vsd531ovs6N1fvAqIsZa5mMP+uPkgw7EkB6Vc8hI8sIT5VuRSnUFYqgWpo/rSJ38JKqy9
	 1Csd+X5S8m70NKlnKuwA4xoWSo5IHZipoYddrDmHvFb5NnboAHSv+iDhBMt6lD/kGgOsC
	 EalS3biu9eEAh8ch8ljH8bTRPzgKXaFhAM9OVnEhJ/fNlD2ANRbezSZmORwxFPw3g4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMQy9l0W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF66606A904;
	Mon,  2 Nov 2026 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMQy9l0W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6712A1F00A16;
	Mon,  2 Nov 2026 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793635451;
	bh=ItvsId50yzDVw06OawIUXmYj/0R1ht6DyNbArDiWRAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QMQy9l0WwNsdcal80wFUmfw0XGrJz5XyyRRwOCsiv9ieQQuwKbHlegbcHj9hvT+rD
	 WAKo8QT9TpwRyZ77/9LDEB8ueMrSuwlhB0CPpG/wHv5aNvom+tXD08PfYa3LKPP2UF
	 3EHljaVWaGBsrl2ySP8kYGpF18i2B4P1AMsuR1YCaBY4Guu5wxhiUfi1V2j3GuRbhw
	 EXfX3hNNLynURbZV0FZaj3n1r/J88SjZVf3hgVDHSBbowmxTYheirQepGksjSi2gj6
	 Obzv2JDmD3EFBWLOwkdYKY7h87HaIcjiKGTzJaWvkj8WXpiEW6du1NaFkN5ARzRtL9
	 n2qhwGxsPh5OA==
Date: Mon, 02 Nov 2026 06:04:10 -1000
Message-ID: <ff8d427a650061733325f00e5442e4e6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.4-fixes] sched_ext: Fix ops.enqueue/dispatch() calls before ops.cpu_online()
In-Reply-To: <20261031170541.710939-1-tj@kernel.org>
References: <20261031170541.710939-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

>  0001 sched_ext: Factor out drain_offline_rq()
>  0002 sched_ext: Fix ops.enqueue/dispatch() calls before ops.cpu_online()

Applied 1-2 to sched_ext/for-7.4-fixes with the following tag added:

  Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
