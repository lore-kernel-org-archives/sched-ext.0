Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9300D2459C5;
	Sat, 14 Mar 2026 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773479091; cv=none; b=qaWj6nEe6lZKaZIkeYzynmwx4GyoYzEFU6+U2XYMpns07dVFTJc9HFljOr4DFRa/8TzUzIRCEzHN7dSqX/ayw07tJKxwNA7vts6NGAuh28Hi2plVOjQF9AZBKjKZUICPNUz9ILn8xIbowx1aFfgoucGrSwaR2s9+6Il5LkNj7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773479091; c=relaxed/simple;
	bh=w4wWsKfgwuwyK6wLp9ak9sb2QQeWum1J2UbHniKD2xU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=BrJTomCsjGbKcitz+C5Eybq8v8sHvqJ64O50i/Rij/3uXFO48Xq675evBf4ayV7MBP7i1fitKPuV0Iwb1vpqpLRwly07ZFwyOXswj3+3EB3YsxRy7Y0hEyjfEoZ63XGfI8PhFpgekUOSWab+RjI2kHYV6PzM8Vw3WY27V/47Uno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYnfnupm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYnfnupm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13391C116C6;
	Sat, 14 Mar 2026 09:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773479091;
	bh=w4wWsKfgwuwyK6wLp9ak9sb2QQeWum1J2UbHniKD2xU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hYnfnupmsONOPc9nNLwfyqIyqUdv9i4mgWAH5UuhoAQ3/5LTDR3Ce/KVfFYVcQs+m
	 71zDMi7q0RCtFE5erKa/bCdeIDgj+gEGG2Lxcw8UNtslG13P6TFKM36z66rB5OzQTr
	 5On47aTL/q/1uAgrTgm7fB7/jWBl2oEEtK5vzx6e7bEe5I0juOp/QtpZ9nD2sfAYaD
	 LjuXnIXfKpeemJcntNo3jjt4wRRNRen5Hb3QJ0NmRuIYLJMvMWDpJ18AbrnVQM89oc
	 l6YreHvXyh4GVqlRtMNJavsvOkEjORQjMVDd8YEfW29L3saRR45L/8boaW8pKO/7Kd
	 dENVrLtMQuTeg==
Date: Fri, 13 Mar 2026 23:04:50 -1000
Message-ID: <f534bb1f4fd0d51fa8d3a1dcacc7ac46@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 jserv@ccns.ncku.edu.tw,
 linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched_ext: Fix uninitialized ret in
 scx_alloc_and_add_sched()
In-Reply-To: <20260314013934.12666-1-yphbchou0911@gmail.com>
References: <20260314013934.12666-1-yphbchou0911@gmail.com>
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
