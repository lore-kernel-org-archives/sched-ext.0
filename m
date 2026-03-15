Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795E721255A;
	Sun, 15 Mar 2026 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773565099; cv=none; b=W44sArTIKpL3UMNq/khJoK1D9/C2s5DzL7aItm3w0gp0Bh6ToguAba0NRmClTFSeorNVLaNrZShIXp6HEflVoMuuBEHUcwE6S2ELkeP3ul2+7aKq+a9E1Dwwx+FAsVj4O56v+xzSU7Ak2PxOxwpu9ConFV4RxLKnFn1QNOqMJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773565099; c=relaxed/simple;
	bh=zcGAo5G1sVMwwrSldm5UyQidgAWr269sjcEb/Peamv4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=AfkGnoYAky6zu6zeEJcQYbPv2fI/b6MFnnp+Yz8qm+nqr47Pzi0Hmp7QUsIk+gCs6dVsXuxnNtKE7FXQzHchpEessbVQSrnpj9gflOgZKbd9QN7BXfKxGaC+FLS9OGuw+d4ZLgKbtl1HtafZoh6zGcAcUriLi+rqcp4GYZq0JUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzA4Wn5C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzA4Wn5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BC1C4CEF7;
	Sun, 15 Mar 2026 08:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773565099;
	bh=zcGAo5G1sVMwwrSldm5UyQidgAWr269sjcEb/Peamv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JzA4Wn5CZfr+UQ9FSJvuE2n3jgbFuYQTlgxwWoE5qMQwSuJQ180ZypDHdmCdeUKcP
	 3KPZw64cokH2qg3K7H0VDAyDMTZKZEg5as/gh+OqURoiZAl0WsT3ZKL08Jy6CtfVnQ
	 VxTzGq7csTokmPmWzeSGZMzQBbw5okHlkzFG0scskVa2n6fREvwrD6obM1LANO6T4T
	 bTot9JIlXE/xFkhy6u6IJxL9AJBr/+q2GafQjznpbvSMTIkP3AYK6wa9zSTgFJnPFK
	 CB2XjWA6xvdbnVBa31kS2Xtnra/FgWPOi9rAjvNJZcnyJF6niA4APppKGVeRAF1L3D
	 rvbQfdsXXMLJg==
Date: Sat, 14 Mar 2026 22:58:18 -1000
Message-ID: <6702f90987edbb368c1101cf81f48b81@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] sched_ext: Update demo schedulers and selftests
 for deprecated APIs
In-Reply-To: <20260315082500.597204-1-yphbchou0911@gmail.com>
References: <20260315082500.597204-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Cheng-Yang Chou (2):
>   sched_ext: Update demo schedulers and selftests to use
>     scx_bpf_task_set_dsq_vtime()
>   sched_ext: Update selftests to drop ops.cpu_acquire/release()

Applied 1-2 to sched_ext/for-7.1.

Thanks.

--
tejun
