Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078753;
	b=R72oRE1Y2QJotu6xKr5pw4T0X4M+l2Vx5FNJMDKVqdoqLfvEtbVEhjc7Y5c+JHW3LyOQ
	 sC0alv/5/Zaru5diJmLF2VfSA8YQPcGPsptu9Xk10nlEraOuCMJiXGoM0HkRvIyAskIk7
	 MDXb9/cj3a3ZZqYCaKtEDG67oqUNZwa8sMOE4wtz0sLPH6wXYt41/zrQ7BGWf0v8+dkd/
	 A3dlZbWwbXNkYXJYIAaThPcWsQWEpPThPcduwHNmlS+UfaiL39wBnR0fvkUXHoNa1EN8t
	 Mrz7PyH0z5KlTQNd7cIlb30Ap9Y47pisyx6s5mtQzdqMw8Tj0GkGSUHokeXxXbYFkuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078753;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=L8uMcSTR8JeHQ+nnG/+1RLwupDKUqnYM2ZJlj8MIHms=;
	b=R9TGN61JUiehDM7Zks3hsoDNmAvJUItFAkAt3ZJCs6BHgrXOQKaeaFI0NvCIDYoNR7B+
	 hBoBpUFbAg4nEJG/KZ8HojvbQucY5yCmlm4grjGzNIotd/LPnK/Nd0nNGNX2lltxd5Q3t
	 y3Q7zt2yAigf+FEHiCPbTbpI/durLtZVDrMv6xtMOjQTEzO4dZs7lGNO/IcXq8wfodAIU
	 u2799P0EKkqeco6zHK3EnUAd5N0IbFTOCAPsnsvetFYQfZkENMLaUSRK0BDm8ve72JtKW
	 CLSV8pVWmEj5KYmw6k9/f8zPALqi1Whsh+mas9JrrAJtulBrZ3feYWufuA2lfWInpzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfGLpo7e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B9B606A320;
	Thu, 19 Nov 2026 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfGLpo7e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1916C1F000C4;
	Thu, 19 Nov 2026 08:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795078752;
	bh=L8uMcSTR8JeHQ+nnG/+1RLwupDKUqnYM2ZJlj8MIHms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZfGLpo7edRw9N+a8JjxR2w2+BBsz9JErVeL5vqkHAa783Iiw60HLPIRfCACuo9Hu7
	 Xknp2Ki9c41soNLeYHwxA+o9BqoHqXApey43+B5NmpWfSU8F2M1klaLgrFZgGQM5UD
	 5bssVVyS1Wc8sY+28syU41qWSbQ+CdihehuUFCt40dCkW/oZiq4N/b32U6xd1Ukm5K
	 9AhiW/YOxOBy65vQ0LIJx3dROL+XQ6gpdCW+v++tX/1PwcdwEi58Se5bBz0oS+y/KA
	 /y68BSP5wjWJALUUZ/5t1UdpgP1b16k0qtO1EyN/3mJhKbAx8RPtQofknqZk7M4zvW
	 ZRDnR3JcdEWzw==
Date: Wed, 18 Nov 2026 22:59:11 -1000
Message-ID: <a41504e9f5b99dd12d4e47ee9b54411d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Tao Cui <cui.tao@linux.dev>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Don't route tasks to SCX before __scx_enabled is fully patched
In-Reply-To: <20261118102453.1315267-1-jpiecuch@google.com>
References: <20261118102453.1315267-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Applied to sched_ext/for-7.4-fixes with the following tags added:

  Reviewed-by: Andrea Righi <arighi@nvidia.com>
  Tested-by: Tao Cui <cuitao@kylinos.cn>
  Reviewed-by: Tao Cui <cuitao@kylinos.cn>

Thanks.

--
tejun
