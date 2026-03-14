Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0130C145;
	Sat, 14 Mar 2026 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773477923; cv=none; b=agrMxgN74F+fhvUEmbcjfvuwbpbIHD3Hr4nnHFDBnnOLLdjsEsybeZRVDDi1CjwfI9IMlmE6IYYcCI6m1hpyfFmLvDbQM65CNErKGPShCBUXWOTcGIWdLcSyLkkTMc+fPaeiPVaXMIVHg/q+OMwJ6OsiZcZ2InqvyVRjgy+jNX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773477923; c=relaxed/simple;
	bh=w4wWsKfgwuwyK6wLp9ak9sb2QQeWum1J2UbHniKD2xU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=c5XJuEPU+aaZVegcTCVbz08hqMzOaTvgZnjO5EvIbuQkHDUL0DLEyIfjxL+9SpSIanWl1r+Vw4CiQ/SUSdv7SAGzvV/yEJj/v3o7hASduDticJ4KPA1VR6QLZZZmvYp+gpUAlBaUcb2Xwn40yGR3Im/vMeL50UFT2r9hOpZth+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khcuLpXv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khcuLpXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA6FC116C6;
	Sat, 14 Mar 2026 08:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773477923;
	bh=w4wWsKfgwuwyK6wLp9ak9sb2QQeWum1J2UbHniKD2xU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=khcuLpXvCXqyU9bWyYBmek6wYEniJGA8hwXVi0MR0JKyDUDc4JLhXFNdbrJxPKLMg
	 NSYM0MucXuS4OMwm72rZSx2XUphH7vWN4/uJQXdJWky3zcZg8F/6K4YQX4WFVSVhzl
	 TK/zDPy991HRTc06PEfRwZkAImcqHi8Jx1Rbd5wdQ+yieeo7uf04CVfze7kkXTda19
	 lB+fCMLNwNOh+qdDHajeBJ2OnYXb2AkSZ1uIhXBNPzAhBs8J5KusSUSiz7SzuauGj1
	 9FTNKjumTCK3D++B/eLgGj4EaOesy1gw/19ADCTgd7t0MYcfufNsEMQ2GQL94P7QT6
	 NOrF4qicT60Uw==
Date: Fri, 13 Mar 2026 22:45:22 -1000
Message-ID: <d71aeb42482734a009806d645d1f0489@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>,
 David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH sched_ext/for-7.1] selftests/sched_ext: Update
 scx_bpf_dsq_move_to_local() in kselftests
In-Reply-To: <20260314065104.113372-1-arighi@nvidia.com>
References: <20260314065104.113372-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1.

Thanks.
--
tejun
