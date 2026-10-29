Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793294865;
	b=QoKpx6b/HfdZuXXB+q5kjwy3mXN9TJz1MHS6fG38Qxt8eHAVaQDCXJGWl5H6tDhEOI9z
	 kLCw6L0c7ps/SxBYo+etWIX2m419klktup5XruYmakW489PkMyPVEn7swHzdpccWfP3vv
	 UyhS/MtaGy+3ElH8q1W1aKjwPaxeCO5To0j1MbbeEJmUhSERxS4sYFzKkz6m+ohM66lBY
	 mgg5B6G14jcRKOPOu2rO6qaUu7WX9YGuLRLkeJ48oA9nNbYrP3KnVcK/DlvUi84r45J+J
	 0onUJBuLQDHSoqlnXf3gfN9jkftH8iYwo86Xi8XzXasj3NTe4zB75X1+BRXuUjqoYLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294865;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	b=MB4ua7uGxnWNQwNZsn8e7qSQ1PVcfd5PZ2H//Mzrd+Hr2etBzNzNJQmWuSwYcoGhsVeN
	 VkzjwYgH0fgiFLmLY27KShXL5aL0CA9T8oW8a0PfxQFQbjBZFAbj/B5acjHWkwM9xcf+i
	 1gOT0P0xSM6PQa/galnmXQHSJ502+lBzLAya5ESDl4ororORAh/waVX32wJPUiFFD3maW
	 M5ULVPy/Qvnx5SSYzkf2OIVePV1XbGZPiEcqJiNOS/PdUCJnItcjDUv46tpIFFAx2S2EW
	 bI1O4VG/o7OKOTmt2qZ7IPBaDzFGo2K7JepXnyvypxIbNuj8sc18UtFN/ufpNXqADQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5mlBlob;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4973606A31A;
	Thu, 29 Oct 2026 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5mlBlob
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B571F01816;
	Thu, 29 Oct 2026 17:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793294865;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D5mlBlob0BR0/kK8WfsO/YtYBNIzac7RIyaTEVZ7cNdm06S595dSzg3PFibBXhC/J
	 1p8I2ZRf4f4prw8Nw+2yQ1IKMALrXFuYlcvMEh2UfqDb6AScDUGf9LfryFJdHvex97
	 OnsVYLd3L6fX4+oqU32md9MGIXlWpU5pW0IRstPhKxZ4H0X82hIXAYf4BwLczP1ClA
	 iqabRCHUOAYaNUsIC1CWT2IX9ZwPcG/Z/zVlMYZHj1dkqqjd29zinew+x70PRnFPhT
	 lFHY44jVzs8Fr05IqsnpVJeobiLJ+w7FH7PiIFByCmAiGBzb59j8ONCnk9n/4+QwmE
	 U8Ft23OGI2Mbg==
Date: Thu, 29 Oct 2026 07:27:44 -1000
Message-ID: <6cd7ae4c7307858e20c88e6fd397d17f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.4-fixes] sched_ext: Avoid unnecessary IMMED reenqueues on idle CPUs
In-Reply-To: <20261029073508.3901589-1-arighi@nvidia.com>
References: <20261029073508.3901589-1-arighi@nvidia.com>
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

Applied to sched_ext/for-7.4-fixes.

Thanks.

--
tejun
