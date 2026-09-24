Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C77C4D8DBE
	for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284460; cv=none; b=Ss8MQe1LVaWpUSM66513U/mbzvax2M7S/UIb8uFmWlmAsHow+5FU0PpLaCNNKFa6deYYkUft8lSpT1mGNSCIDPhV1rJhR1FJUlcNtEJXcD+5AKNxyYLgJrt00rULZnspX6N+MixNrdUvDlnZWsceIRzDQq8ne1Q88RCireFEC3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284460; c=relaxed/simple;
	bh=5X3f5LMt+1ktDBnXdlEqojvUHL8tu4LtqubxC2AZFIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjNn1M4dc/mtvXwcur1Uy2qX9QGgms7jxd5Yvf8Vr46URZNWgQtIkScllJJshVu2EqG2ZgYnqY3OaSZEVLEoL+2nhriux0ASKIMZel/Kvq3LZ9fqFHK2QewqZRovS3pkdkCNWBFWHlZUil35hAGoS5pUaYVJcBeld9GYHVD0AFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8T0MmiR; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8T0MmiR"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d097b4939so1650015e9.0
        for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790284453; x=1790889253; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UP/G1wPiXPB9Uw9yyDuA781szVvayYuXNNrSB0GIav0=;
        b=d8T0MmiRy/wSAPEX7Z8lZSJpkiee4sylkPtOKk73cbUz0SrrmhBqq7WZpMqCKEtWn6
         MB3BKHQNbM7cZWWkxrBqeSeabgCtLucLLnn3BGbVxlAkmHFRbaocvC23qYP4XsdvCHbT
         tWEaWKzvShozZ81vVgFkEVwLvaiHIWt2kBRbTJBmnDzVETNpiAa0fJpaEh0uaSjxH5An
         gyZyC+uguGvugPCZw9YX9QIBZwtbWgdt9o26xidglAXDK4RVq5muOPbH1WcoVZxwsBVI
         hR2kS8VAR/q8+3LC+tI3V0bolXX0ey44BvrE0TXb1AkQ1cS6Jn4reBpeoMalIUxC9igd
         O1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790284453; x=1790889253;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UP/G1wPiXPB9Uw9yyDuA781szVvayYuXNNrSB0GIav0=;
        b=GcbZ4w0JxOQWRkJAr2zK5qMWqxBh3tQB8/lEF8sIENRjk2UmqiG168JCTq2IqEW+89
         55wU+ihVcNLDMy1JxkAEfEWFtsSpkzAhZcOL8NC5k87qvQhu6gg6IgKy8/O+Abp8B8pI
         8cNVf93JTecdUaXMl1sqzTp2o0584z9iFNyTKZEYqaPHBZ94vRDrD/P8UMjuP8ODTxyS
         J0J1828FD8NJfX7qJ15GFKXRxqJYZ8UxQEhpwVSVUYjZ7+ZKBztX6bN/Nw4zL5v7a7vt
         FGb3gLwFhfrG47f2Q0pZb54Ks1/R2cRP8fLrwVclvqxqC8M9XHY8ekll1G/lFZ5zvThG
         bJrg==
X-Forwarded-Encrypted: i=1; AKwUvBwct6R0ea16v0VebJeseftwmEEZ7M0xGIfkQOlc5+edHUWeQfVUki8SyXxH4nrz7uJvZS0jJvS8iDQ=@lists.linux.dev
X-Gm-Message-State: AFuF++l0cUHotD4zURODxVjPeDjqLOqjlD9xraa9Mhum1dyzpM6mlPXE
	iw7cr54lZg9Pqjij9YZQtTfcupuEDnuARyVL1DZoH+GRAz3t9m9rnfu1
X-Gm-Gg: AYBFou0jo6CjveBPQ0Q6Bkd/JaTb5Xjt8IBpkS5qWNHUiIZ/uhLJj2IY5i1WsKMJCVu
	n3fsqZxqAGeUHNncRnbr4ZhAeTttmmyT4pIAe49wu67L6ld83FvIrUPG7GBQ19EFSdJDZDrrQwE
	bCwV8IKWo3Lx9xmRt94O8m+bn6gmZCsxNCYIbNzKXp/2yMq9XSRv3IWoO6nygscZeYyhWx7qmXl
	hJPr08V5idYq2ZTQZZFVNdpKUWKfbSMmQXFKZknEO4AH2Sd3iyI+GIgm3kss/lGJqnwHBfXVU8L
	LQL5D3iYhSjei0HaCeE+a5PaEQOP/RgfN/K/vpcwTRqd2riKo1NOuaQhOvFYd/e2KfgKzGyb9EV
	VjY2AHqCg1qpfsEc0nUo+8/oS5a6LtWgmN/g793CK4tbbk6N0jjxjckwqd8R0PtBTZBwaDeINgq
	/13jgIQlTUssz2Yp4f9nXHbQLr93eLliUpnqEoHPqryw1C2Q/apFCN1H5/v/OTFkG4P+uzx5fbP
	c3bNhxf+W/WusaaxJFcGQuaX6hLM7OoAcQ=
X-Received: by 2002:a05:600c:3b1b:b0:49c:de80:b833 with SMTP id 5b1f17b1804b1-49fe66c8a1emr68629125e9.2.1790284453344;
        Thu, 24 Sep 2026 14:14:13 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef4fc959sm10167455e9.2.2026.09.24.14.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:14:12 -0700 (PDT)
Date: Thu, 24 Sep 2026 22:14:11 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, justinstitt@google.com,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, morbo@google.com, nathan@kernel.org,
 ndesaulniers@google.com, Thomas Graf <tgraf@suug.ch>,
 nickolay.lysenko@gmail.com, peterz@infradead.org, rostedt@goodmis.org,
 sched-ext@lists.linux.dev, tj@kernel.org
Subject: Re: [PATCH] rhashtable: specialize default comparison for constant
 parameters
Message-ID: <20260924221411.0fad5501@pumpkin>
In-Reply-To: <20260924184733.2317353-1-usama.arif@linux.dev>
References: <20260924184733.2317353-1-usama.arif@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 11:47:33 -0700
Usama Arif <usama.arif@linux.dev> wrote:

> The inline lookup and insert helpers receive the rhashtable parameters by
> value. With a static const parameter block, key_offset and key_len are
> compile-time constants at the call site.
> 
> The default comparison throws that information away by reading both fields
> back from ht->p. Fixed-size keys consequently load the parameters and call
> bcmp() for every object in the bucket, even when the compiler could use
> scalar comparisons instead.
> 
> The commit "sched_ext: Specialize the DSQ hashtable compare" [1] resulted
> in a 2.9x faster DSQ lookup after replacing this path for its u64 key
> with a scalar comparison. Doing that through obj_cmpfn requires every
> fixed-key user to provide its own callback.
> 
> Pass the call-site parameters to rhashtable_compare(), as
> rht_key_get_hash() already does. Use them when key_len is a compile-time
> constant. Retain the ht->p path for dynamic parameter blocks. A constant
> zero key_len continues to take the runtime length from ht->p.key_len.
> 
> This specializes the default comparison for all fixed-size users. With
> Clang 22 on x86-64, bcmp() disappears from sched_ext, mac80211, NFSd,
> TIPC, NFQUEUE, VFS superblock, pidfs, SysV IPC and hardware-breakpoint
> table paths. The affected build_policy.o, sta_info.o and nfsd filecache.o
> text shrinks by 512, 400 and 352 bytes respectively. Four- and eight-byte
> keys become direct scalar comparisons; six-byte MAC addresses become a
> four-byte and a two-byte comparison.
> 
> Measure the VFS case with ustat() on a mounted ramfs. This exercises
> user_get_super() and its super_dev lookup. Across ten interleaved baseline
> and patched VM boot pairs, with five 3 million call samples per boot, the
> average per-boot median latency drops from 477.2 to 462.6 ns per call, or
> 3.0%. All ten pairs improved.
> 
> No functional change intended.
> 
> [1] https://lore.kernel.org/all/20260921171928.1639407-1-usama.arif@linux.dev/
> 
> Suggested-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  include/linux/rhashtable.h | 20 +++++++++++++++-----
>  lib/rhashtable.c           |  5 +++--
>  2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> index 57a2a29bef0e8..c9872965b753c 100644
> --- a/include/linux/rhashtable.h
> +++ b/include/linux/rhashtable.h
> @@ -598,13 +598,23 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
>  	for (pos = list; pos && rht_entry(tpos, pos, member);		\
>  	     pos = rcu_dereference_all(pos->next))
>  
> -static inline int rhashtable_compare(struct rhashtable_compare_arg *arg,
> -				     const void *obj)
> +/*
> + * Use constant params from inlined callers to specialize memcmp(). If params
> + * isn't constant, it must be equal to ht->p.
> + */
> +static __always_inline int rhashtable_compare(struct rhashtable_compare_arg *arg,
> +					      const void *obj,
> +					      const struct rhashtable_params params)
>  {
>  	struct rhashtable *ht = arg->ht;
>  	const char *ptr = obj;
>  
> -	return memcmp(ptr + ht->p.key_offset, arg->key, ht->p.key_len);
> +	if (!__builtin_constant_p(params.key_len))
> +		return memcmp(ptr + ht->p.key_offset, arg->key,
> +			      ht->p.key_len);
> +
> +	return memcmp(ptr + params.key_offset, arg->key,
> +		      params.key_len ? : ht->p.key_len);

That looks strange to me.
If ht->p.key_len/offset can be different from params.key_len/offset I can't
see why that shouldn't happen when params is constant.
If ht->p is likely to be a pointer to the associated params, you are passed
the params, they match and params is constant then you can optimise.
But that needs the address compare in the calling code (outside any look).

David 

>  }
>  
>  /* Internal function, do not use. */
> @@ -632,7 +642,7 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
>  		rht_for_each_rcu_from(he, __rht_ptr_rcu(bkt, freq), tbl, hash) {
>  			if (params.obj_cmpfn ?
>  			    params.obj_cmpfn(&arg, rht_obj(ht, he)) :
> -			    rhashtable_compare(&arg, rht_obj(ht, he)))
> +			    rhashtable_compare(&arg, rht_obj(ht, he), params))
>  				continue;
>  			return he;
>  		}
> @@ -797,7 +807,7 @@ static __always_inline void *__rhashtable_insert_fast(
>  		if (!key ||
>  		    (params.obj_cmpfn ?
>  		     params.obj_cmpfn(&arg, rht_obj(ht, head)) :
> -		     rhashtable_compare(&arg, rht_obj(ht, head)))) {
> +		     rhashtable_compare(&arg, rht_obj(ht, head), params))) {
>  			pprev = &head->next;
>  			continue;
>  		}
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 6362896e4f099..9d9f03b59c823 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -548,7 +548,7 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
>  		if (!key ||
>  		    (ht->p.obj_cmpfn ?
>  		     ht->p.obj_cmpfn(&arg, rht_obj(ht, head)) :
> -		     rhashtable_compare(&arg, rht_obj(ht, head)))) {
> +		     rhashtable_compare(&arg, rht_obj(ht, head), ht->p))) {
>  			pprev = &head->next;
>  			continue;
>  		}
> @@ -710,7 +710,8 @@ static struct rhash_head *__rhashtable_next_in_table(
>  		rht_for_each_rcu(he, tbl, b) {
>  			bool match = params.obj_cmpfn
>  				     ? !params.obj_cmpfn(&arg, rht_obj(ht, he))
> -				     : !rhashtable_compare(&arg, rht_obj(ht, he));
> +				     : !rhashtable_compare(&arg, rht_obj(ht, he),
> +						   params);
>  			if (found) {
>  				if (match)
>  					continue;

