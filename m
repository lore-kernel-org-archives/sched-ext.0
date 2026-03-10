Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FAA3624C4;
	Tue, 10 Mar 2026 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163069; cv=none; b=K3RS5W2H5mKHepoYPzPZJH9reJhOMQ3bRyqedPB0qYhtKe61/ciUBSb9VIQzNcc0UxYGoAyb9LTbZYpF3eImBIzFUBocrgW8Zu+oXYYPRpbVUxEKtH6Aq9M3W8g36L/Ed/gwtF5X+UNCbk4AbJbIB7kng+32Bb4gzir3m0SS2TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163069; c=relaxed/simple;
	bh=6XsrxXgIMRZ1QkDE4kAEXu1PzyMa77AOK6k8cEXk7Gk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=cz6xA9lL+EvKnavksy05k4HgkKOIe8x5xIiwMLQonTULb1wnNPrw4z8pesb5sxBf8lSqTECDQJjNXrh1Fw2bkBrT0S8Sf2QXeGA6VXm7NcCHuydcxTzfw9Nuos/uRiG97/0ZADlAF+5sNE2IygGQZmSbETeJKHPc/ASGI3yxBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJhGV2T+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJhGV2T+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94C0C19423;
	Tue, 10 Mar 2026 17:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773163068;
	bh=6XsrxXgIMRZ1QkDE4kAEXu1PzyMa77AOK6k8cEXk7Gk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OJhGV2T+JJrqn2lrNh03KFiBhP27O2T7rF0nob57zxdZQdd/fDeUmKElv3uBmumZs
	 bD/C67FINLv+TrtItzJVRMRcRSHU9npAPXhcCtszv2JHj8x1EnklcTWPZuAwnM503J
	 Z0VKQYfJiJoWJJcWWRmAM7MFYtsDHxzn5AudFgeFSlGxfM9rELPtHKby9cO7YNu6eg
	 8xJdxHYDOFSmXj/ysbXPc2LP3nuzuz62Jdxnhy70izBbg5Rp2BGWiZS52Rc0xOlvOH
	 NDfM4oXCK3cP/eTeuPAdG6fMSkFdCHgpu+igHl5yLFX+SCBXUioZxH9WEau9VpT/ik
	 egIwbJX9Yby1g==
Date: Tue, 10 Mar 2026 07:17:47 -1000
Message-ID: <0b022932479ed2d6d0c6cfd8e8d82fd9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.1] Fix sub-sched locking issues
In-Reply-To: <20260310011653.2993712-1-tj@kernel.org>
References: <20260310011653.2993712-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1 with Andrea's Reviewed-by tags and
corrected Link tag in patch 4.

Thanks.

--
tejun
