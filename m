Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB353B95E3;
	Sat,  5 Sep 2026 22:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788649070; cv=none; b=O2mBIYXgZmUomBWhf/u3CSctszJR6pLt2WPA+DuwEsdNDD0nw2saBMpUzjLR/KijmS6P8edsws2PJbG0KT5poc7oi5tnr3jBPOE8FAlKenxse9rLKeGk/lRl32nqHteVT0CTgAUI3UA9EMISeM5dhJA1UW3GKBpgLWHK+8BegpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788649070; c=relaxed/simple;
	bh=GNv138Dy/qz9o4pgYW390AwwY4kt2FflmrtGaUu5RRE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=rZykAsF7eL0tMkPsWK+opjbaKudNhr+hyZ0qzOE1tUWQJ3yfanoY7o/CELywohicG2hGhB7fkfV4lFtbWMsjBgMF9e8QS3ulvcDSqYZRmPGA8nkAB/gjTYqHsckaK1zaVU4YUYu8XkkauzanEBBv/IHQd4FIL7ZpdTjtpf0wx1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFsT4TqL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFsT4TqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEB21F00A3A;
	Sat,  5 Sep 2026 22:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788649067;
	bh=aCCUUebekDrCMtWHtUAIfe3agnXzsPLaenMDuDu+ET0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bFsT4TqLJaskBdFNT6AwPlMA+walIo30mHkIRWzmuXo5s6tDJwfZ+qy2I79qE0pQM
	 yxdz8jN54vM2rY0dgJuTuw99m2ecVrXET88FhFE/JH2B1djRH+JuuDBD0DWwiAM7n7
	 WI0Gv4DW7S7bH2hO3BcufQLtYYnvKWCubpZ7dYFFq9WW93IXNSGHsBJ0FjO9/8KptQ
	 dXIahHFYQgmREjYNTPyevBq/9s80M+uayFb58LGoX2pqyEeNHzHuUW+rP0rgKfHkPS
	 XJLJklSubzGBfmNWqtNGXbKSwMPyCEf5gGY/ZGt/VWHQqeIc5Zmk5ZwFfNlfqjtdtP
	 OY/asbNnWj5ww==
Date: Sat, 05 Sep 2026 12:57:47 -1000
Message-ID: <e715598cd2ce5dd3984f88f94dac8f7a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, sashiko-bot@kernel.org,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes 4/4] sched_ext: scx_qmap: Place
 only on cids whose caps are in effect
In-Reply-To: <apxsZjPo7IzPuC1x@gpd4>
References: <20260905160958.1565156-1-tj@kernel.org>
 <20260905160958.1565156-5-tj@kernel.org>
 <20260905162223.6EF521F00A3A@smtp.kernel.org>
 <c1b5b24af15ee3e117bfa07f8c89aad2@kernel.org> <apxsZjPo7IzPuC1x@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

Posted a fix:

https://lore.kernel.org/r/4c9a9c9cabc3547e23bae5ae00421a52@kernel.org

Thanks.
-- 
tejun
