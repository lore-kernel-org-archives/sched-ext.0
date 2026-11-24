Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543028;
	b=sIbUIg5M0c702S09DS0pyEIFVJFb3D3SFgIZ999iCe8PWDp2g60HnfckbwLWAroud9Wo
	 hs7wZkLNkZ8av7p560o3KuyVOthN9VvqoKT0L2MGCFQi8bYXQLIaU2P0Op0laBJMlZkkw
	 B8sdRtIfKVyp1pVW5pCxMkKVQFbdsIy/L9TeX5pHmHzSWouOutGlOAiNQJLDMUlijoWvk
	 Vz0Ty1Npt0YSKF7B8fVPgoJPrDA/fbwJ2MhqQyW2iIT7Ulr5FuZLGltWBStnCKUfXjx6U
	 ohFHGo7516AbUmcQ2G4w0DEr3Vxny/O/4RyzDD46YcQ/TLbzQIpIqP8f8fo82F2gNjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543028;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OL3gP810bqf0d17gNnBpCny/0hJkDJ4XH0dG+giXl44=;
	b=B62OwkjqaNzHhLc0moc8RtiOmusJNxHh/ObLp6ViiGDCWIG2eH41yWZwM+5tcdpSdfuC
	 OWK5Zt3d3tPjGO8h+r66GWJ/PHG+1QqUgzV8e/8qy0qUqEyFGm+lRYSWdU3omruFLH04M
	 YZfZrS5uZfbNLnXw0dDCNX81/KKtbLEW+jNIgYIKDXfU6S+1zis5m8um2N0Pb21UJtB4N
	 Oz0fJ7zsGRyu3zxAP0s0B8btjpV3hyzLy5KtDXWaTIQe5szh9ggkn7q7P4H1tPVRnFQIq
	 Y3QIZNAnuFHYvbCEHnL9KakSQ0FAAH/Zb5EKSlSF2pdAhbluB4CR3QK8qwJRkkGUHFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PCU/pz2T";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F880606A31E;
	Tue, 24 Nov 2026 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCU/pz2T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9851F000D1;
	Tue, 24 Nov 2026 17:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795543027;
	bh=OL3gP810bqf0d17gNnBpCny/0hJkDJ4XH0dG+giXl44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PCU/pz2TQcvmVHlAJDHlOEMXCzkoOGr+tIEkypUmFrNOGd7Xfnq7uDdWmWdmWt7Mn
	 03Jn+O02p5J1grKA7g4HHU0oRrbzMU1xwhS+Whm/+G70YVxHzWjgRTDS2BveVPf5LN
	 +BVStqPucXH5K9x2Y+3rwxC9NBkkyBQAg2J73hNSseNmticszsifi/VMEGTyWR64JT
	 U+6wDZe6cZayYWqEydkiSTAztg7n4AcwYH9IdlSRHe5pdptCOkUWxPR5H1eZ/elYPi
	 4CXEBQnwAxI+GAFqMQa5LcgcjDSUB3VDrgSZlFLVvwXJh2MEnCZNg4xaxl8uPVdZrw
	 beLWap/BG0tWw==
Date: Tue, 24 Nov 2026 07:57:06 -1000
Message-ID: <cd51ef480bd455b0d1dff7c40d77ccb3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: reject oversized exit_dump_len
In-Reply-To: <20261124161543.1225966-1-rhkrqnwk98@gmail.com>
References: <20261124161543.1225966-1-rhkrqnwk98@gmail.com>
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

Applied to sched_ext/for-7.5 with the Fixes tag dropped.

Thanks.

--
tejun
