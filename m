Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99A38332B;
	Mon, 11 May 2026 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778539608; cv=none; b=Kg+qcOAlkfoOO9rsGC8/+swpTTNrj9lhqn4gRRTP5lST13ra1JeG1KS5+s/Z+xQ156Sho7/BGftbZ6v2MiP7Is+vKkJLjf3Yjx4fiPfRNzT0XR/68lBzc98q4zlvJK4m1OvvUfJSw9YnqMMFsoGAzbq1EGvGQPw317Qz83EUJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778539608; c=relaxed/simple;
	bh=txM0jDKzfi5J3pUFAoizvlgsBku4SNZjTkpxb3nB9Sw=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=s/emCn5r4KHa15QUUUcCafVfZHQXw9pTVQYTO6qJsW784pQEU9g2s6a+QtvLf+QkYcSX7ngaxUNr/7SCAz5AxfFUd3qjwHfBI4AbUt9loZJ6pdxYsXqCXfd1DPkG3rhs60bslK5uZRpZ9d0rJf512Fnn+HSRfIveZkIlf5CFqMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMrCIi8P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMrCIi8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2E1C2BCF5;
	Mon, 11 May 2026 22:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778539608;
	bh=txM0jDKzfi5J3pUFAoizvlgsBku4SNZjTkpxb3nB9Sw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SMrCIi8PhwD4Us7jsq+ZMiM2UjS5+4dYHNs0FwfvrVcwXLMn5oxS0Bb4wJDSBjyVM
	 Jy79XfmK7CxJSEUIsQhihZHUvSgZW/uOqNM9zBvI/abL/O1EvQWxOvi8wzgIxU+mNH
	 JSCoDNs8IA40CpftwRjXrYZ2I/MS/83DFjSupsXF0msN3S+IJ9OrFnCivy/5SZ052t
	 ABuT3OCwz2/vzsisaOX4ptER95maSfi7/wig1jpUeafStEeOwbWX99kJuEmSfkJnZc
	 D/66FY13EL1bJ5r/pwn9O23APDwmT4IpK6GGr8kCx0wd9vkk4/Be0Pp38aoIW5VZ09
	 4SZVg1M2GA2dA==
Date: Mon, 11 May 2026 12:46:47 -1000
Message-ID: <5a0c496bc89840d9ab1ed5faa28ec3f0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20260511220335.144621-1-tj@kernel.org>
References: <20260511220335.144621-1-tj@kernel.org>
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Avoid UAF in scx_root_enable_workfn() init failure path
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1-fixes.

Thanks.

--
tejun
