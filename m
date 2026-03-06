Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB3D2206AC;
	Fri,  6 Mar 2026 04:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772770712; cv=none; b=HR30QmnrAwavB/yg0arkIVCSx2ZuqPqMtSZgXdG73tvaAC0KZei5p1Cppd0HzfLNhA8xQ1/5PfSkvmcvGWoTWffwBDFHum3Xj0ubcRjW9Alkqf7hOYiWhRGOT1OgrchtYwbwuxutLSzDhvXX2uEevEn3skkEdh8JY6QELQGJiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772770712; c=relaxed/simple;
	bh=urUqqMmm8T38ebYC5yTiTAYu6e35k5DzPxYZ3A+P3PE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=WahA4NTguloVUfBYw47wGY1EER1OQUDbLAs0iZS6ozlAl2Bt9nTZtIcrphOq4BwJOKBIyZnPJkzSGwZXVL+QUMtKktwHuP1n4BsA3U/cg1+NUBdo0bQlfh5cCxy20iK97D8NGRrq6V633VEKeuyrgbFQE72zrpghm2UV2G15ugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql5ZA2zy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql5ZA2zy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B36C2BCAF;
	Fri,  6 Mar 2026 04:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772770712;
	bh=urUqqMmm8T38ebYC5yTiTAYu6e35k5DzPxYZ3A+P3PE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ql5ZA2zyBMfk/PnN8xe6wCxAQBDov5J11ZfUVUpWvfg+X+RZ7/yL2/qZXePwTATrJ
	 KqjcjoqZENV6UNe0+vhdHX/y5+F3fhrgqxp9SRHOck6VovNQ7W0L7VkhPwPRH7hZFf
	 wNFR+YHiGNsAY48eDkxPYQQ3ZW7pLk+VLg+IchQxIJ95yTfnVDFJzVQe3pygdL9zdC
	 pToLGmj9PJeVObLj6PUZk6Z9C9yrZzSHyhyN2iycC7ZzybFst47yYjuCDIoBqDZFnY
	 PZCwx0QpV4f+Ck9PDm1w6isMDXczKmRxUW9X6z5vqcR4JHAdSMgJV0Z9I+IlwBIB86
	 oxTl5IFNfhdEA==
Date: Thu, 05 Mar 2026 18:18:31 -1000
Message-ID: <5bbee628ab3dce4f4c25e2ae72387998@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 emil@etsalapatis.com
Subject: Re: [PATCH 04/34] cgroup: Expose some cgroup helpers
In-Reply-To: <20260304220119.4095551-5-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
 <20260304220119.4095551-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to cgroup/for-7.1.

Thanks.

--
tejun
