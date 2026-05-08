Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850DE33998;
	Fri,  8 May 2026 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263151; cv=none; b=Rzt4w+8SAqD4P9RIDDNaHBdc2P5QkjGiDmz9nx+HJqfZ3MuB1/f9DQRy8xiZTWM5bCJ8Mk4RthREi7jC9D55uaRV18Dhcs8eT6gnoMd1vNRd6W/xYxkkgxDF/rhtWDrSvWkDjSse/ERs1+Xe7OBD3WvgPmcdz1foWoI6ojIqF1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263151; c=relaxed/simple;
	bh=QQ6rfCUQGcmCn8QN2RzYQhEFBF1Xu43gWJeIRLdkOBo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=EzlrG05+Yebx3cm2dHF1hhHTLitiGgnz5RX2D41TeOcpGJjR/dk7tgv9ME3l/FtiTFyxcXB155RoH9RxFIRzyD9vavybEo/ma/b5ZWU7NzTFCi0E4RdCWWUXoDXci50ejLEq+xelYF/jywICzhAKLtc/hk8gqjbFr2agKmsl8/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+nLsEa5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+nLsEa5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363C7C2BCB0;
	Fri,  8 May 2026 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778263151;
	bh=QQ6rfCUQGcmCn8QN2RzYQhEFBF1Xu43gWJeIRLdkOBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m+nLsEa5uog1u7I8UPnsX01C/vgORs2CBhmWUSJRgrK3CXwQdCb2HFx5IxXSgcCiX
	 L4CHjPNK2zuEEth0Qnal0CIrEX2hPkm1h29tfftcn3f45NOhs2B4tXbsV+CTsCZmwD
	 wpqbfSCZ8CCxYh67ikXJQ/m95aaOIBkFubBn3rcg6HQcvbKauvftYKNBXeOEVbm4D5
	 TPFjsYjK1QwuALoTRVK37RVlHNnTvk5J7T6onHmv/nJ4jJdU2HbJM6g8ku+rZ3XiGd
	 swpFXbxCc8agooCwWoQlmU/zuanMfF0PHU6xwCZTgpfUpepgtFUHvlwohFg5iIqZOH
	 ylI4j4BsKE7DA==
Date: Fri, 08 May 2026 07:59:10 -1000
Message-ID: <9d3acd70cff2553b2fbf0d5807404071@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	void@manifault.com,
	changwoo@igalia.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [RFC][PATCH] sched_ext: Allow consuming local tasks when aborting
In-Reply-To: <af4FmAr5sVfkWcHI@gpd4>
References: <20260507135642.692290-1-christian.loehle@arm.com>
 <af4BHTzRaDx8aZPh@slm.duckdns.org>
 <af4FmAr5sVfkWcHI@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Fri, May 08, 2026 at 05:47:36PM +0200, Andrea Righi wrote:
> There are few selftests that use stress-ng in tools/testing/selftests, maybe we
> can put a script there calling stress-ng, if present, and a sched similar to
> scx_simple and if stress-ng isn't present, skip the test. Do you remember the
> stress-ng command you were using? Probably we can even reproduce the issue
> adding something to the C part of the scheduler that mimics what stress-ng is
> doing.

Dug it out of shell history on the test box. It was the workload from
b7b3b2dbae73 ("sched_ext: Split the global DSQ per NUMA node"):

  stress-ng --race-sched 1024
  stress-ng --workload 80 --workload-threads 10

Run both in parallel on a 2x EPYC 7642 while flipping a SCX scheduler on
and off in a loop and the live-lock reproduced reliably.

Thanks.

--
tejun
