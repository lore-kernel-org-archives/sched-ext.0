Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0344727FB3A;
	Fri, 24 Apr 2026 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061740; cv=none; b=u8l9Yy025YI/n0qTJ+oj1+VCKHPdcchu635yOFnV2iLcfXKaC3rSOQ5dX4OCeiCwjuWFU1S2p9gMhNrGUYSmKea0VWzgbXiisnDkNh/DBAoqyMo51QD9z/qRJfEQXl41+X/9szDtQWCZxT9LKn2W4QmnB0J6yY7ADVLXFlmOfTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061740; c=relaxed/simple;
	bh=CDgjRSfWjauXTP+nZxp69cSO4ke1qLiBM7aXnSkujFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDRjd9QEWtWI6nGO+/y+F17N0SECx0TrISh4p2dOvw6v66NicIZn7yQoHPKX5ux0ZwONq7nwIKTamB9X7hXQvAAjqCxKHVujZHnwAJDEw/j635H6Wa+EuMHD6Oa8+px4LCUBDkEEoBUxW+oso0xpPyAMJb4HOoOw7UzPo0BUCPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXyXLK5Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXyXLK5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A417C19425;
	Fri, 24 Apr 2026 20:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777061739;
	bh=CDgjRSfWjauXTP+nZxp69cSO4ke1qLiBM7aXnSkujFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXyXLK5QHF+i0ddUZBiJqFAVm10klmau+z55LOXkVahWGPicH9RaQHIcN/nMe0Ttf
	 HrhM0V6e9O+J3Yl2Lw0SZBJjg/dXMRivcMvCAw2leAjXli5FCYDbuhkpKGd8f1fbBQ
	 n0ZMJpntSyHMWX5IOSc+UhTdVLrabX2oLINDk2A9DsxNxi8ldhwmVuWrbT1MnacrK6
	 0ECaOJhPjfKDScsMfJfFMfBdZWiVrMIywTCi0joStrZULxTyYc0LLVGquu+wkQaf9W
	 qYfiuzPTkWHNTqnY4TlsVUEvDk1ILM/7gl20K7/lVAadfURHzTZ3ByrI16IyUgShc8
	 J+zRwPt+iF3Fg==
Date: Fri, 24 Apr 2026 10:15:38 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, emil@etsalapatis.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Defer
 scx_hardlockup() out of NMI
Message-ID: <aevPausscftqxWpS@slm.duckdns.org>
References: <e78c625bf7ef51fef0e564d9c25482aa@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e78c625bf7ef51fef0e564d9c25482aa@kernel.org>

On Fri, Apr 24, 2026 at 10:14:32AM -1000, Tejun Heo wrote:
> Cc: stable@vger.kernel.org # v7.1+

Please ignore this non-sensical stable cc.

Thanks.

-- 
tejun
