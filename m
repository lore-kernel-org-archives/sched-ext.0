Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036022;
	b=H1ml44vi8ZhgFd2T6jBMoB1xwN3iuAVgZPb/Esvxd0L0ev1oXeiAS4+JQxkaET5zdJgf
	 4BFAyYvgsGww2n+zYOQFf7AsBUmi7zz+hhg17oJbfMt12NzHP/40qD5toLCvPu08mBhuc
	 iGg4fxAHt5aMPJsKcW5D1sdxte/5cXnkul6EJ+k7pgOGfSomXDUI27n1iEpqigvvKDhL1
	 ppHPr/vxlplu9EzP353p+GHAbgbyZH4WU5CVv3ITT6Pj8qy+VuaxLUpONXGPe1PPp4gOJ
	 +O9lVvvM04TSD1E74KZMos/giEpxLh09Xb7Bal6GEbJqI23rtWV2B8fbY76oaqyXNGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036022;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=I9NQOc1mhS4mDXnmba+nVe9LmZzsc22eBiEIS2qzy0o=;
	b=IAd66uh6nmFKPQmscRvfNyy5j59rOy0TSjqHcMJiL//719fJBs8hXtH+KGoe1EKeqQGQ
	 QpxK3TaBYzoBoZcO9o9S2/+8fwajXwQc+Iw8B9nsg/tGcqhnWVysnZfNACoei49EOOU9s
	 BG4myUgfG9TPyHgvub2EOi8lSaHQaTlTA8zftizUwki9UA/OT1YQxosqzbQbXMjIkFYFs
	 yRVHz0MnNyIiHFAWCLfp4X9IQZriPIpQ+zDCYKvX2TGIWScrouxZ3bHNTbkPsTGHSGV4F
	 R7anvLXnBiM4bY5uXSePVJkgvmZvLGqOIvPv+EYftrLBcgKzPU3RKaR3pDzNTRLZUdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJ3CXZBI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6E606A335;
	Mon, 26 Oct 2026 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJ3CXZBI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980321F031E1;
	Mon, 26 Oct 2026 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793036021;
	bh=I9NQOc1mhS4mDXnmba+nVe9LmZzsc22eBiEIS2qzy0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hJ3CXZBIgZi1oG1gzbUDj5tZf7kavMQ1fWbhfRAIF6j6VKb+tEzZjBsLoR7CEFCZj
	 pNOFEHskBxfapmMPpYU4C1DZMfaA3miSk68lYryEBsJjQQ8ugUDmEWof2nmNA/5PEX
	 Cnx6CSw7caD/pQBZkoE3o7H9y+LlfOpjXva7teNpHuWnqjaMUEp6uhhqyW0JF3NR7/
	 I93oFnDosRM6aIy50zIWhRFArdhZvyP7mIIL+cNlZ31y0LVk7I5pD8r1Q5oFZ1Yl0A
	 Fj6w9qH2hP20tm8zjX/pFY6Iae+WTOS2y7WNcuXz+VRgZ/7LJRv5HzzChsUPMmZzqp
	 zcsGjRJaqdxQQ==
Date: Mon, 26 Oct 2026 07:33:41 -1000
Message-ID: <a87912f2dea62af99230f1b32149b083@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.5] sched_ext: Sync tools headers with scx and fix unsigned enum reads
In-Reply-To: <20261023232102.1124938-1-tj@kernel.org>
References: <20261023232102.1124938-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

>  0001 sched_ext: Don't sign-extend unsigned enums in __COMPAT_read_enum()
>  0002 sched_ext: Sync tools autogen enum lookup tables from the scx repo
>  0003 sched_ext: Sync common and compat headers from the scx repo
>  0004 sched_ext: Drop stale entries from the enum lookup tables

Applied 1-4 to sched_ext/for-7.5 with the following changes:

- 1 is the v2 posted as a reply to the original.
- Added to all:

  Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
