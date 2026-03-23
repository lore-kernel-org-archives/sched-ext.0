Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453C12571BE
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287329; cv=none; b=jWfgWM0huSN+EW3g4MhKtYPqYvejCwmCy1D/oe/RpiLsQZN8uGLDi6MUI4V+TTetFBVMFfqQaOJ5tVN/vCCVKXYXxsssc/wwDcvogtq7J9DCxGhrRs4Iw4D4dFIXyGXh6DLEB0bUy0eUXaNaPBxdpTtfZyEIIPHnJJ3hUSdzdII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287329; c=relaxed/simple;
	bh=qiyJohTZ8qiETI6JBYaReYEU9UfQOp43y1M96NyThjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT3ZF9FyFdIGBfA5boJq/+JzOG1I19vwlcQQuTljyjc+6lrjMEjB0uRkocJ4yUZj49MsDH80cMZkAe7kLJ/g2MDqPQ1CsMvqZvknMEBfFW2k8mT4wEjYbUU1qX0G4rpHYYxI9zJr2UMIg8S9VVu4LWv7GYaQ/CjMR9la/GVngyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aj8yaAd9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aj8yaAd9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3418C4CEF7;
	Mon, 23 Mar 2026 17:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774287328;
	bh=qiyJohTZ8qiETI6JBYaReYEU9UfQOp43y1M96NyThjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aj8yaAd9uP6/q2MXgPtyrXSJZGajcL7TPRnn7qZZow2D8z2Ui2JADs/ks+qcTIJgc
	 TirUktVbtFbA6pCcYhNDOiIZwpmTh41ujl8BcGItleTgstUhcP2PgmsioU+b4z44M2
	 5cHLI1NEaMUW7FbSQuFmoBi8kf1GW5S0CvG1AFOw/CHeM6aTnAoKjs+fVfDtd25SRR
	 1ggh1wAi0N/bOawZw5bvvzmN/D99tS2AZ2WqzHr3NbYjjiQnN8fhE00D45nSwofuYm
	 IzMaPs/KP1rVQ6k0VN51f9c7s7DcOpj3rWnHgy0yvnm9FDjeoMyvef9eupGfUOIhc+
	 6gXAqmDvWtQmw==
Date: Mon, 23 Mar 2026 07:35:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [RFC PATCHSET sched_ext/for-7.1 0/3] Remove __COMPAT prefix from
 BPF compat wrappers
Message-ID: <acF53-EU7azY08Me@slm.duckdns.org>
References: <20260323172145.25689-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323172145.25689-1-yphbchou0911@gmail.com>

On Tue, Mar 24, 2026 at 01:21:27AM +0800, Cheng-Yang Chou wrote:
> As suggested [1], move away from the __COMPAT prefix and make compat
> wrappers transparent so schedulers don't need code changes for
> compatibility.

I don't think we need to create churn for this. We can just avoid adding
__COMPAT on new ones and phase out existing ones over time.

Thanks.

-- 
tejun
