Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516723C3F4F;
	Mon, 20 Jul 2026 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533029; cv=none; b=pNw9u0WvMeJqax6QPAbD73Z5vQ3hACtoi32SmF6ayuAnwzFL5RbsQVyP7cWdesjJHcMUNcQFTfCocorTNXju9D3bAM7lXyvCLq6EZQq4IVk3xMixvYOzd+sEU4WJlAuBS+HwDryvhdZgkhBuUP0yiDQhsh+Qs4vOqB+R9fbFwp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533029; c=relaxed/simple;
	bh=q4HAKN8mvKvCJsdc+sEBkiolq5RvR3+CflIdq0qKwL0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=eK516xhiGAZ32gw2/nXD1qNi6loP2R7d+FOaRLxYPbw4JENYAPzLM9F2OpTjK8iggyC3r9dvCHobVdPUKN9Ipvr9+pO7uw7lmsRxknCt0LvRKat1BBsAi9pJXq1z9wKpZXgpXnwds9rPz8xENNzFjbF04/tH+6qkCJnF811hCn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtMZVBqR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtMZVBqR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB981F000E9;
	Mon, 20 Jul 2026 07:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784533027;
	bh=q4HAKN8mvKvCJsdc+sEBkiolq5RvR3+CflIdq0qKwL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gtMZVBqRczCEbxXdA2fU+69a5rAY9Q37zEdaYWIRrNzW+LOpbLJkEt3geKc481gju
	 p4adcbWGfUR4BfHwxsn8rX19dTp3wWaFfiniIVRWGTRk5KWBRbpeiaK0R43huPYLDG
	 0+e60N5PhutW3Xa0YY4hWt6CEGGrVxKrE2bbDZbPsUEHl5oVCfPLCTvjEAuE8wxMPM
	 76cXqEqzTIKF1qt7lwE5KkEoYWQj6Atvc0UxUT49c08sTMHDFyaTrIjqZr1OWTuCs+
	 lpqyTT7HayJRoM6d2Vw6YAhcVOu2UZO33C7uw9+eU7qy9rmIrOhDcki77Y+2C5CsKj
	 fk5zzYoQ85vkQ==
Date: Sun, 19 Jul 2026 21:37:07 -1000
Message-ID: <0d9ca9e4d02a1067bc2b726427d1222d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET sched_ext/for-7.3] sched_ext: Rename the cid-form cgroup ops to cpuctl_*
In-Reply-To: <20260718101029.725350-1-tj@kernel.org>
References: <20260718101029.725350-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied 1-2 to sched_ext/for-7.3.

Thanks.

--
tejun
