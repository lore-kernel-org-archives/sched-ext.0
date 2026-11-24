Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529131;
	b=dh3JpcqVvmIO5LBhVNHeDRlbH1HApt3F/Kuy2omvS/4P0fkjKaAPVsgxjQwSK04y0JQ8
	 /qbngcxCmP9NhefBcARlCZZ65sXbnvBFxMACtSbmEk6cHJh7DiCL0GKvKD4VoLHdPMEqX
	 TqD20m9XYdZpnvhjwk40ldKEk0bdkF5m9kREHjyoBz2/Fi+IDjATgtfNx7QG150LDrvg9
	 vmJExBiCR9OFWyEJmKda/u8Tvk3ZLGm9d89KtNg1Xcuq6BQxDT86Z/Cl8qUQASqAvWITQ
	 uIgifgVe+vQ+EA2pPHZefOnpt3GwglABl3Uqh9OyADf6umFoWJG6YGostxH48au2KSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529131;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=G0HxVZ2fKAuto9CPFoN4SeBuzTTmTZXV8O6Aikqs/tE=;
	b=FnS2kT8Z1V+zSryT87OXryJZfBrxD3xmv2KZgbzM2N6YRj9bDBAmjUqtfMfwVpNF4MoS
	 6r1UTM7HTL6QnDc1Pxktoor4aBZllRvVxpzGcaJy2+4S3XG9kU5n1GdRZCn58vDcmgrwd
	 pgRWsyWk6aW7aeUYiCAtlTtZENgyMykN43c3/kbLMuOYrPiOk2SmdGfAgjaKvm24Lp8Td
	 E2v3jlPLzE59zTIyJhE5YitFCHg9G/frot2x7eD/xMBDnNbnEQjoygMI0C/iDO/cmMDt5
	 Izwdy1YpVpiCCvrzf07HGtTrLovqry79xzBc2GNN1nisTumgAOzU7R5kNlMzzrk7PgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUuIMhOz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C2B606A6A9;
	Tue, 24 Nov 2026 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUuIMhOz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8776E1F000F4;
	Tue, 24 Nov 2026 14:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795529130;
	bh=G0HxVZ2fKAuto9CPFoN4SeBuzTTmTZXV8O6Aikqs/tE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dUuIMhOzYEDUqLN7r9Y9C6XBwXXWOgv8Ylw+afBW+VLBBAejmLvpCjer+1fw7aS+6
	 +wqAd7Sh+3VuXJ/Bycry0sQ7qfx7iTZeiWJlyIlopLb5EAr3HRe7FrW43+LmDm7aHL
	 xQOKbZWplaLZjAKrSeUNF78Iw4YI5m0OZBavY5xzUr8eE1rL7M7ILRT47vKXzYTqWs
	 mM8LtcW/icgJkmGPJQULDfroAj15xhm8DZdQH1FyhFfPSuYoCY97Sh77++gibBjcol
	 BaAEM3Wtc31s9h3hMRvUq4bCeG7A9IKNKLa6e7oqpg+nHouO1JVhv5jrHvJLso3PZv
	 keeWCnsl0Z2hg==
Date: Tue, 24 Nov 2026 04:05:29 -1000
Message-ID: <07a90f0f36c010fffb626a80b6275772@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: reject oversized exit_dump_len
In-Reply-To: <20261124100508.1060692-1-rhkrqnwk98@gmail.com>
References: <20261124100508.1060692-1-rhkrqnwk98@gmail.com>
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

Hello, Sechang.

On Tue, Nov 24, 2026 at 10:05:03AM +0000, Sechang Lim wrote:
>  	case offsetof(struct sched_ext_ops, exit_dump_len):
> +		if (*(u32 *)(udata + moff) > INT_MAX)
> +			return -E2BIG;
>  		ops->exit_dump_len =
>  			*(u32 *)(udata + moff) ?: SCX_EXIT_DUMP_DFL_LEN;

Maybe read the field once into a local and test that?

  	case offsetof(struct sched_ext_ops, exit_dump_len): {
  		u32 dump_len = *(u32 *)(udata + moff);

  		if (dump_len > INT_MAX)
  			return -E2BIG;
  		ops->exit_dump_len = dump_len ?: SCX_EXIT_DUMP_DFL_LEN;
  		return 1;
  	}

Thanks.

--
tejun
