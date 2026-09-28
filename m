Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9AE397352;
	Mon, 28 Sep 2026 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621067; cv=none; b=bw+gxKhtWZh8ggiY2xJoFLxIg90gAk/LMTgNUHNPMHpGr6syfUizFqKAogaydBZOm7I8DCSFtepvQgb2HngGB5FAWyiERY5jMPTiAqQiag/swICHV75daICivv5hUBoGcnEKUFfhLg4o949sUSFhA/CG0UZ/oPfdAdchvSkovCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621067; c=relaxed/simple;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=nQdZd9utkXeWUms5mX3TXKDy2T/HE7SPloka9Pp76UEYwBJPHAunnjZRqeAK4GNiUOai91SeybyZrDtrT2H1xqQT1ZAGxUXp1+HEkOC6e3ktJP1DP3bb5oHK6Q0c9L/WQikQkitcAAk/T/fluiwiSkGBM9v/4UfKlC9imcBgkOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBHff6oM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBHff6oM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62011F00893;
	Mon, 28 Sep 2026 18:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790621065;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jBHff6oMtiqt5KUjZwfk/kIttyRdnlAXauirNJSrTuea83BO7TXRvawWQAlJ4e7dy
	 Qx3AAFUoLbAzb9FiXnPqfhrgvK7Mk0io1Dctnd3KHS76sAllmiCYWEfshkaE7rvljl
	 EbDbNRRqkcV2KLiwyIXzv+vMtycHN3d+gg5+CF2Q74WF6A5cGPfe9WT5ifGYSPwbxh
	 qyX6tE5DB6h5o3rzi+6ACKkfIiTLIJNApQys2hFHF72+//nucXTQmvbyts/S8sVXKK
	 iYvq+btJ1wVkVNOk4jXYDx+ncQwqSC1ypN4mMJbdAdaAxKQS26uBSNlwxw1Exki1wf
	 s3DyZ/DF77lsg==
Date: Mon, 28 Sep 2026 08:44:24 -1000
Message-ID: <55340bef0e2f44cde6bd5f0616b68da0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.4] sched_ext: cid: Represent clusters
 explicitly
In-Reply-To: <20260927133719.3458770-1-arighi@nvidia.com>
References: <20260927133719.3458770-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.4.

Thanks.

--
tejun
