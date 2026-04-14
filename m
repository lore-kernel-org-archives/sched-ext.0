Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7BE1D5CC6;
	Tue, 14 Apr 2026 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187384; cv=none; b=cXhQgMQImWfU2aK+OfYtcblbUGWeFrLzxmp9sJyRKQztSkx71DTGlFOetPTFdQ24XX6qM5mDWh/1yjzPy584i/puF5zFbL8COB7bW1bgHi7PhE8ixAOA9qxMe4gy8k+bY8eAxIG8EICWnYPq7LrS2NgsHafoU8LAspMXGbR0B/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187384; c=relaxed/simple;
	bh=EtIXgDtZije819G8S+TgKYxLQZojM3MCshppot01HrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCb774q9EPEpJX5HHjcy/MzkfVuDWu3ap+Gj0cPBrto2IOiqOLlY0YUJ36+7ZvTKpszuzp+eJT9xU7xCBek9Puw0ui4pYXeLplH56myTIbIg6KkvHqgw9NAgP/VhvJk6DldEvQxUQ5QhWyBvuw8+mYIhdYmJcSY2uH2Cj4v3Naw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMNdnmbO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMNdnmbO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F21C19425;
	Tue, 14 Apr 2026 17:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776187383;
	bh=EtIXgDtZije819G8S+TgKYxLQZojM3MCshppot01HrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMNdnmbO6/hgGRunEyZcTnrDbh8WCz/W1Ut1UBpBOyVHU70OUaY5w/cqpm9cvsyfD
	 hUXRzCUjfjjtyBCx5ty2NvVTgtH+DfE920TbsUQsd7sV07wnLyNnPt2Xbbh1Bzvd8T
	 CJvjqkY1JBoLQFAmp+fcP5/Vy2X2JJqMhSE1A7a9tkRIQRdPxN2hevo/1q1/CWT4CL
	 MqsZs7O+7QyWavbjOHMOv+m/ISbxxPE1YM97MYjwG4A5xbNI9n8JuAdtsMeXzypSU8
	 5NZVsIqqW4Z+UwAFTsGNNTeDbE1KigXV8NlMt3mVgbG6mdC3WT0nFQ0lkCp2L3LI+f
	 yiS7g5jMHCiuA==
Date: Tue, 14 Apr 2026 07:23:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Fredrik Boettger Bratberg <fredrik.b.bratberg@gmail.com>
Cc: Henrik Austad <henrik@austad.us>, Peter Ziljstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>, linux-rt-devel@lists.linux.dev,
	sched-ext@lists.linux.dev
Subject: Re: [RFC PATCH] sched: add CONFIG_SCHED_EXT_RT_EXPERIMENTAL to move
 SCHED_EXT above SCHED_RR/SCHED_FIFO
Message-ID: <ad539mUd8A0lDWAw@slm.duckdns.org>
References: <20260414125933.3520885-1-fredrik.b.bratberg@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414125933.3520885-1-fredrik.b.bratberg@gmail.com>

Hello,

On Tue, Apr 14, 2026 at 02:59:33PM +0200, Fredrik Boettger Bratberg wrote:
> A recent paper published in the 2025 Real-Time Systems Symposium (RTSS)
> "Enabling Flexible Scheduling in ROS 2", would presumably also benefint
> from this feature. The paper aims to address and improve the real-time
> capabilities of Robot Operating System 2 (ROS2). As part of their paper
> they implement an EDF using sched_ext. They do not explicitly address the
> issue of their EDF SCHED_EXT tasks effectively having a lower priority than
> SCHED_NORMAL, but it is a known limitation of the current sched_ext class
> placement

Isn't that mostly solvable by just not putting tasks in DL/RT and enabling
switching_all?

> This change conditionally reorders sched_class selection such that, when
> enabled:
> 
>   STOP > DL > EXT > RT > FAIR > IDLE

The problem is that RT being above EXT is required for safety as EXT depends
on RT superceding it for enable/disable path forward progress guarantee. If
you put EXT on top of RT, it's relatively easy to stall out the whole system
without any way to recover it.

Thanks.

-- 
tejun
