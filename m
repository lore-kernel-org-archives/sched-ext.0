Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792707646;
	b=FoVBchv8u4PAOWXjed5iyu6uZX4jvbc7OWH/dQ9YkK90l5DIfrhCKZ/AqNzlsPAoTEz2
	 Sg99iK2iIn3Tes3Bm7arwKSQzX/4WZ5KrIhu+1Y9wJqSSMKx4uBptn5ymy5cTw6Ay4BpZ
	 vrs22WMOmzzQcCJqzQk9vyL5BIPuJg92kUuVgADGnXKLvqW+mTh1f9uOr+NzoiEDCSQzn
	 fvg6w9NJQ5zIemXZw4EjL/vxqA/CpZIIKQjDRCBS/Z/yA9ro3WAwCD2ury4e726UaKoiL
	 s+8LFEfH6a5zNjoJC6NLXa8bkh9pLutpCpKh3QAZVanHITD6d0yY83FECkvGZhjcKdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792707646;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=+GNZ2D747p9f3TNF3gotnBgEIwwVPlUAxlz889vNLC4=;
	b=wowXNJrkY+nG2lx1LplfsaCmZPXlAHdNL3a9aF7WD6qLFtytVgCu1ONQLm74BUFudVG0
	 xueZ7dgk48GxZgEBwQPNN7UrTbo/VSs1Bzit0lgNfk4BwGBNK35j4z4VZjgUFP2xOElT8
	 V/UPZxIAMb6RSm4y7M6K6TqHj7tMnHu998XUspTtekwUHbJhlGidlgKw9iSbUnmO2S8eY
	 L95qpP2Wq23/M1DaevA25sZtWIGv6QMOPL0/kDjByjMAlap2bXKD21YGRyHFCs9qGAXHz
	 4P1Y9fM7q+GMUbVXHCEt0TMzrafVA+HW/vpj5gMKwh9HrGDJRSGS+s8yV7CnsUZB3/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgsAGdN5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D16606A31B;
	Thu, 22 Oct 2026 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgsAGdN5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4391F01825;
	Thu, 22 Oct 2026 22:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792707645;
	bh=+GNZ2D747p9f3TNF3gotnBgEIwwVPlUAxlz889vNLC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fgsAGdN544Tpk/xid5yAksghUx6S9FgrlEpDomlcNe7b30KsCNqw2f7YGwiE9whsG
	 9vNkQfv3YT5Q2pcIVwnC1N1wOfJI6G/HAaV5WLJxsKk2fSOR8BF61OFNdN8/xD9WAC
	 ysffo/Ahu93mo+zkwT+mX9q8RiDUAjgYXjb44NibxvePsrdoZ1F2+E8I2q+fM0E1tm
	 LQeqwU2GBGJi/33sC1CyRtEW+eCh1ra6SHtDXEf09ppyWLMDX5AZGekRACZ+FYLgfF
	 n7eotZlhPrBDGfoyRnhexhpAmKq5PkZux7nueKeKa+y4kX4yql1By9vLexdqZO0bVx
	 GrBwri5Bg04pQ==
Date: Thu, 22 Oct 2026 12:20:44 -1000
Message-ID: <d1370714620d401548f4458f8e4cd24e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.5] sched_ext: scx_qmap: Drop the compat code and fix a lowpri starvation
In-Reply-To: <20261019213221.2919481-1-tj@kernel.org>
References: <20261019213221.2919481-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

>  0001 sched_ext: scx_qmap: Drop the compat code
>  0002 sched_ext: scx_qmap: Queue re-enqueued lowpri tasks on their FIFO

Applied 1-2 to sched_ext/for-7.5 with the following tags added:

  Reviewed-by: Andrea Righi <arighi@nvidia.com>

I'll follow up with the changes needed to drop the remaining
__COMPAT_ENUM_OR_ZERO() for SCX_RESCUE_DISABLE, including regenerating
the enum tables.

Thanks.

--
tejun
